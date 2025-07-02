import Foundation
import AVFoundation
import SwiftUI

// MARK: - TTS Manager
@MainActor
class TTSManager: NSObject, ObservableObject {
    static let shared = TTSManager()
    
    // MARK: - Published Properties
    @Published var isSpeaking = false
    @Published var currentSpeakingRange: NSRange?
    @Published var currentSpeakingText: String = ""
    @Published var currentWordIndex: Int = -1
    
    // MARK: - Private Properties
    private let speechSynthesizer = AVSpeechSynthesizer()
    private var highlightTimer: Timer?
    private var currentSessionID: UUID?
    private var lastMeaningfulRange: NSRange?
    
    // 실시간 측정용 프로퍼티
    private var speechStartTime: Date?
    private var speechEndTime: Date?
    private var pendingSegments: [String] = []
    private var pendingText: String = ""
    
    // MARK: - Initialization
    override init() {
        super.init()
        speechSynthesizer.delegate = self
        setupAudioSession()
    }
    
    // MARK: - Private Methods
    private func setupAudioSession() {
        Task {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                // Audio session setup failed
            }
        }
    }
    
    // MARK: - Public Methods
    func speak(_ text: String) {
        // 이미 재생 중이면 중지
        if speechSynthesizer.isSpeaking {
            stop()
            return
        }
        
        let utterance = createUtterance(for: text)
        
        Task { @MainActor in
            prepareForSpeaking(text: text)
            speechSynthesizer.speak(utterance)
            // TTS playback started
        }
    }
    
    func stop() {
        Task { @MainActor in
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.stopSpeaking(at: .immediate)
                resetSpeakingState()
                // TTS playback stopped
            }
        }
    }
    
    // MARK: - Private Helper Methods
    private func createUtterance(for text: String) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: text)
        
        // 사용자 선택 음성 적용
        if let selectedVoice = getSelectedVoice() {
            utterance.voice = selectedVoice
            // Voice selected
        }
        
        utterance.rate = 0.5 // 학습용 속도 (느리게)
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        utterance.preUtteranceDelay = 0.1
        
        return utterance
    }
    
    private func getSelectedVoice() -> AVSpeechSynthesisVoice? {
        let selectedVoiceName = UserDefaults.standard.string(forKey: "selectedJapaneseVoice") ?? "Hattori"
        let japaneseVoices = AVSpeechSynthesisVoice.speechVoices().filter { $0.language.hasPrefix("ja") }
        
        // Try to find the exact selected voice
        if let selectedVoice = japaneseVoices.first(where: { $0.name.contains(selectedVoiceName) }) {
            return selectedVoice
        }
        
        // If selected voice not found, try default voices in order
        let defaultVoices = ["Hattori", "O-ren", "Kyoko", "Otoya"]
        for voiceName in defaultVoices {
            if let voice = japaneseVoices.first(where: { $0.name.contains(voiceName) }) {
                // Update the selection to an available voice
                UserDefaults.standard.set(voiceName, forKey: "selectedJapaneseVoice")
                return voice
            }
        }
        
        // Fallback to any Japanese voice
        return japaneseVoices.first { $0.language == "ja-JP" } ??
               japaneseVoices.first ??
               AVSpeechSynthesisVoice(language: "ja")
    }
    
    private func prepareForSpeaking(text: String) {
        stopTimedHighlight()
        currentSpeakingText = text
        currentSpeakingRange = nil
        currentWordIndex = -1
        lastMeaningfulRange = nil
        isSpeaking = true
    }
    
    private func resetSpeakingState() {
        isSpeaking = false
        currentSpeakingRange = nil
        currentSpeakingText = ""
        currentWordIndex = -1
        lastMeaningfulRange = nil
        
        // 실시간 측정 데이터 초기화
        speechStartTime = nil
        speechEndTime = nil
        pendingSegments.removeAll()
        pendingText = ""
        
        stopTimedHighlight()
    }
    
    // MARK: - 실시간 측정 기반 하이라이트
    private func startMeasuredHighlight(for text: String) {
        stopTimedHighlight() // 기존 타이머 정리
        
        let sessionID = UUID()
        currentSessionID = sessionID
        
        let segments = pendingSegments
        guard !segments.isEmpty else { return }
        
        // 백업용 고정 간격 (실제 측정 전까지)
        let backupInterval: TimeInterval = 0.25
        
        // Highlight started
        
        // 첫 번째 세그먼트 즉시 하이라이트
        highlightSegment(segments[0], at: 0, in: text, segments: segments)
        
        // 나머지 세그먼트들 백업 간격으로 시작 (TTS 완료 시 정확한 간격으로 전환)
        var currentIndex = 1
        highlightTimer = Timer.scheduledTimer(withTimeInterval: backupInterval, repeats: true) { [weak self] timer in
            Task { @MainActor in
                guard let self = self,
                      sessionID == self.currentSessionID,
                      currentIndex < segments.count,
                      self.isSpeaking else {
                    timer.invalidate()
                    return
                }
                
                self.highlightSegment(segments[currentIndex], at: currentIndex, in: text, segments: segments)
                currentIndex += 1
                
                if currentIndex >= segments.count {
                    timer.invalidate()
                }
            }
        }
    }
    
    private func finishRemainingSegmentsWithAccurateInterval(_ interval: TimeInterval) {
        // 현재 진행 중인 하이라이트 중단
        stopTimedHighlight()
        
        guard !pendingSegments.isEmpty, !pendingText.isEmpty else {
            resetSpeakingState()
            // Highlight cleanup completed
            return
        }
        
        // 현재 하이라이트된 세그먼트 인덱스 계산 (대략적)
        let currentHighlightIndex = max(0, currentWordIndex)
        let remainingSegments = Array(pendingSegments.suffix(from: min(currentHighlightIndex + 1, pendingSegments.count)))
        
        if remainingSegments.isEmpty {
            resetSpeakingState()
            // Highlight cleanup completed
            return
        }
        
        // Completing remaining segments
        
        // 남은 세그먼트들을 정확한 간격으로 순차 완료
        var segmentIndex = currentHighlightIndex + 1
        for (i, segment) in remainingSegments.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval * Double(i)) {
                Task { @MainActor in
                    guard segmentIndex < self.pendingSegments.count else { return }
                    self.highlightSegment(segment, at: segmentIndex, in: self.pendingText, segments: self.pendingSegments)
                    segmentIndex += 1
                    
                    // 마지막 세그먼트면 정리
                    if i == remainingSegments.count - 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            Task { @MainActor in
                                self.resetSpeakingState()
                                // Highlight cleanup completed
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func createConsistentSegments(from text: String) -> [String] {
        var segments: [String] = []
        var currentSegment = ""
        
        for char in text {
            currentSegment.append(char)
            
            // 1-2글자씩 분할 (일본어 특성 고려)
            if currentSegment.count >= 2 {
                segments.append(currentSegment)
                currentSegment = ""
            }
        }
        
        // 남은 문자가 있으면 추가
        if !currentSegment.isEmpty {
            segments.append(currentSegment)
        }
        
        return segments
    }
    

    
    private func highlightSegment(_ segment: String, at index: Int, in fullText: String, segments: [String]) {
        // 정확한 위치 계산
        let nsString = NSString(string: fullText)
        var searchLocation = 0
        
        // 이전 세그먼트들의 길이만큼 오프셋 계산
        for i in 0..<index {
            searchLocation += segments[i].count
        }
        
        let range = NSRange(location: searchLocation, length: segment.count)
        
        // 범위 유효성 검사
        if range.location + range.length <= nsString.length {
            currentSpeakingRange = range
            currentWordIndex = index
            // Highlighting segment
        }
    }

    
    private func stopTimedHighlight() {
        highlightTimer?.invalidate()
        highlightTimer = nil
        currentSessionID = nil
    }
}

// MARK: - AVSpeechSynthesizerDelegate
extension TTSManager: AVSpeechSynthesizerDelegate {
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        Task { @MainActor in
            // TTS playback started
            
            // 실시간 측정 시작
            speechStartTime = Date()
            currentSpeakingText = utterance.speechString
            pendingText = utterance.speechString
            pendingSegments = createConsistentSegments(from: utterance.speechString)
            
            // Real-time measurement started
            
            // 백업용 고정 간격으로 시작 (실제 측정까지의 대기시간)
            startMeasuredHighlight(for: utterance.speechString)
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in
            speechEndTime = Date()
            
            guard let startTime = speechStartTime else {
                // TTS playback finished - no start time
                resetSpeakingState()
                return
            }
            
            // 실제 재생 시간 계산
            guard let endTime = speechEndTime else { 
                resetSpeakingState()
                return
            }
            let actualDuration = endTime.timeIntervalSince(startTime)
            let segmentCount = pendingSegments.count
            
            if segmentCount > 0 {
                let accurateInterval = actualDuration / Double(segmentCount)
                // TTS playback completed
                
                // 남은 세그먼트들을 정확한 간격으로 빠르게 완료
                finishRemainingSegmentsWithAccurateInterval(accurateInterval)
            } else {
                // TTS playback completed
                resetSpeakingState()
            }
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            // TTS playback cancelled
            resetSpeakingState()
        }
    }
} 