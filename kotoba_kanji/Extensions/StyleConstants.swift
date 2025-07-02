import SwiftUI

// MARK: - Style Constants
struct StyleConstants {
    
    // MARK: - Card Dimensions
    struct Card {
        static let height: CGFloat = 540
        static let cornerRadius: CGFloat = 16
        static let horizontalPadding: CGFloat = 20
        static let verticalPadding: CGFloat = 24
        static let topPadding: CGFloat = 50
        static let bottomPadding: CGFloat = 20
        static let maxWidth: CGFloat = 100
        static let numberFontSize: CGFloat = 14
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Double = 0.05
    }
    
    // MARK: - Typography
    struct Typography {
        // Fixed sizes (deprecated - use dynamic sizes instead)
        static let japaneseMainSize: CGFloat = 26
        static let japaneseSubSize: CGFloat = 18
        static let koreanMainSize: CGFloat = 20
        static let koreanSubSize: CGFloat = 15
        static let romajiSize: CGFloat = 13
        static let grammarSize: CGFloat = 15
        static let conversationMainSize: CGFloat = 18
        static let conversationSubSize: CGFloat = 14
        static let captionSize: CGFloat = 12
        
        static let lineSpacing: CGFloat = 3
        static let minimumScaleFactor: CGFloat = 0.6
        
        // Dynamic Type Support
        static func dynamicSize(for textStyle: Font.TextStyle) -> Font {
            return Font.system(textStyle)
        }
        
        static let largeTitle = Font.largeTitle
        static let title = Font.title
        static let title2 = Font.title2
        static let title3 = Font.title3
        static let headline = Font.headline
        static let subheadline = Font.subheadline
        static let body = Font.body
        static let callout = Font.callout
        static let footnote = Font.footnote
        static let caption = Font.caption
        static let caption2 = Font.caption2
        
        // Korean Font Support
        static func koreanFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
            return Font.koreanFont(size, weight: weight)
        }
        
        static func koreanDynamic(_ textStyle: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
            return Font.koreanDynamic(textStyle, weight: weight)
        }
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 20
        static let huge: CGFloat = 24
    }
    
    // MARK: - Button
    struct Button {
        static let iconSize: CGFloat = 16
        static let frameSize: CGFloat = 44
        static let navigationSize: CGFloat = 44
        static let cornerRadius: CGFloat = 16
        static let circleRadius: CGFloat = 22
        static let backgroundOpacity: Double = 0.1
    }
    
    // MARK: - Animation
    struct Animation {
        static let cardFlipDuration: Double = 0.5
        static let standardDuration: Double = 0.25
        static let quickDuration: Double = 0.15
        static let fastDuration: Double = 0.08
        static let snappyDuration: Double = 0.12
        static let autoSlideDuration: Double = 0.3
        static let autoSlideInterval: Double = 0.3
        
        // Spring Animation Properties
        static let springResponse: Double = 0.4
        static let springDampingFraction: Double = 0.8
        static let springBlendDuration: Double = 0.15
    }
    
    // MARK: - Colors
    struct Colors {
        // Light Mode Colors (deprecated - use adaptive colors instead)
        static let cardBackground = Color.white
        static let appBackground = Color.appBackground
        static let dividerColor = Color.gray.opacity(0.3)
        static let textSecondary = Color.gray
        static let textTertiary = Color.gray.opacity(0.8)
        static let textQuaternary = Color.gray.opacity(0.7)
        static let buttonBackground = Color.gray.opacity(0.1)
        static let shadowColor = Color.black.opacity(0.05)
        
        // Semantic Colors
        static let speakerActive = Color.orange
        static let speakerInactive = Color.blue
        static let conversationIcon = Color.green
        static let favoriteActive = Color.orange
        static let favoriteInactive = Color.gray.opacity(0.6)
        static let userBubble = Color.blue
        static let systemBubble = Color.gray.opacity(0.1)
        
        // Adaptive Colors for Dark Mode Support
        static func adaptiveCardBackground(_ colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
        }
        
        static func adaptiveAppBackground(_ colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(UIColor.systemBackground) : Color.appBackground
        }
        
        static func adaptiveTextPrimary(_ colorScheme: ColorScheme) -> Color {
            Color(UIColor.label)
        }
        
        static func adaptiveTextSecondary(_ colorScheme: ColorScheme) -> Color {
            Color(UIColor.secondaryLabel)
        }
        
        static func adaptiveTextTertiary(_ colorScheme: ColorScheme) -> Color {
            Color(UIColor.tertiaryLabel)
        }
        
        static func adaptiveButtonBackground(_ colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(UIColor.tertiarySystemFill) : Color.gray.opacity(0.1)
        }
        
        static func adaptiveDivider(_ colorScheme: ColorScheme) -> Color {
            Color(UIColor.separator)
        }
        
        static func adaptiveShadow(_ colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color.clear : Color.black.opacity(0.05)
        }
        
        static func adaptiveSystemBubble(_ colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : Color.gray.opacity(0.1)
        }
    }
    
    // MARK: - Haptic Feedback
    struct Haptic {
        static let lightIntensity: CGFloat = 0.6
        static let mediumIntensity: CGFloat = 0.7
        static let strongIntensity: CGFloat = 0.8
        static let maxIntensity: CGFloat = 0.83
    }
} 