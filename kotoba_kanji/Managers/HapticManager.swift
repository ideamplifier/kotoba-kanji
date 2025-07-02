import UIKit

// MARK: - Haptic Manager
class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    // MARK: - Public Methods
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat = 0.5) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.prepare()
        impactFeedback.impactOccurred(intensity: intensity)
    }
    
    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.prepare()
        notificationFeedback.notificationOccurred(type)
    }
    
    func selection() {
        let selectionFeedback = UISelectionFeedbackGenerator()
        selectionFeedback.prepare()
        selectionFeedback.selectionChanged()
    }
    
    // MARK: - Special Effects
    
    /// 카드 뒤집기용 인상적인 햅틱 - 실제 카드를 넘기는 느낌
    func cardFlip() {
        // 1단계: 카드를 들어올리는 느낌 (약한 시작)
        let lightImpact = UIImpactFeedbackGenerator(style: .light)
        lightImpact.prepare()
        lightImpact.impactOccurred(intensity: 0.3)
        
        // 2단계: 뒤집는 순간의 저항감과 릴리즈 (점진적 증가 후 강한 완료)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // 중간 저항감
            let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
            mediumImpact.prepare()
            mediumImpact.impactOccurred(intensity: 0.7)
            
            // 3단계: 카드가 완전히 뒤집혀 착지하는 느낌 (강한 마무리)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
                heavyImpact.prepare()
                heavyImpact.impactOccurred(intensity: 1.0)
            }
        }
    }
    
    /// 부드러운 카드 넘기기 햅틱 - 더 세련된 느낌
    func cardFlipSmooth() {
        // 시작: 가벼운 터치
        impact(.light, intensity: 0.2)
        
        // 중간: 점진적 증가 시뮬레이션
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            self.impact(.medium, intensity: 0.5)
        }
        
        // 완료: 만족스러운 완료감
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            self.impact(.heavy, intensity: 0.8)
        }
    }
    
    /// 물리적 카드 뒤집기 시뮬레이션 - 가장 현실적
    func cardFlipRealistic() {
        // 카드를 집어들 때의 미묘한 진동
        impact(.light, intensity: 0.1)
        
        // 뒤집는 과정의 연속적인 햅틱
        let intervals: [Double] = [0.05, 0.08, 0.12]
        let intensities: [CGFloat] = [0.3, 0.6, 1.0]
        let styles: [UIImpactFeedbackGenerator.FeedbackStyle] = [.light, .medium, .heavy]
        
        for (index, interval) in intervals.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                self.impact(styles[index], intensity: intensities[index])
            }
        }
    }
} 