import Foundation
import SwiftUI

// MARK: - Auto Slide Manager
class AutoSlideManager: ObservableObject {
    @Published var isAutoSliding = false
    @Published var shakeOffset: CGFloat = 0
    
    private var autoSlideTimer: Timer?
    
    enum SlideDirection {
        case next, previous
    }
    
    // MARK: - Public Methods
    func startAutoSlide(
        direction: SlideDirection,
        currentIndex: Int,
        maxIndex: Int,
        onSlide: @escaping (SlideDirection) -> Void
    ) {
        guard !isAutoSliding else { return }
        
        isAutoSliding = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + StyleConstants.Animation.standardDuration) {
            guard self.isAutoSliding else { return }
            
            self.performAutoSlide(
                direction: direction,
                currentIndex: currentIndex,
                maxIndex: maxIndex,
                onSlide: onSlide
            )
            
            self.autoSlideTimer = Timer.scheduledTimer(withTimeInterval: StyleConstants.Animation.autoSlideInterval, repeats: true) { _ in
                guard self.isAutoSliding else { return }
                self.performAutoSlide(
                    direction: direction,
                    currentIndex: currentIndex,
                    maxIndex: maxIndex,
                    onSlide: onSlide
                )
            }
        }
    }
    
    func stopAutoSlide() {
        isAutoSliding = false
        autoSlideTimer?.invalidate()
        autoSlideTimer = nil
    }
    
    func shakeCard() {
        let shakeAnimation = [
            (offset: CGFloat(12), delay: 0.0),
            (offset: CGFloat(-12), delay: 0.08),
            (offset: CGFloat(6), delay: 0.16),
            (offset: CGFloat(-6), delay: 0.24),
            (offset: CGFloat(0), delay: 0.32)
        ]
        
        for animation in shakeAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + animation.delay) {
                withAnimation(.spring(
                    response: 0.25,
                    dampingFraction: 0.9,
                    blendDuration: 0.1
                )) {
                    self.shakeOffset = animation.offset
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func performAutoSlide(
        direction: SlideDirection,
        currentIndex: Int,
        maxIndex: Int,
        onSlide: @escaping (SlideDirection) -> Void
    ) {
        switch direction {
        case .next:
            if currentIndex < maxIndex {
                onSlide(.next)
            } else {
                stopAutoSlide()
            }
        case .previous:
            if currentIndex > 0 {
                onSlide(.previous)
            } else {
                stopAutoSlide()
            }
        }
    }
} 