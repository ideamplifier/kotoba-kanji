import SwiftUI

// MARK: - Font Extension for Korean Text
extension Font {
    
    // MARK: - Custom Korean Fonts
    static func koreanFont(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .bold, .heavy, .black, .semibold:
            return customKoreanBold(size: size)
        default:
            return customKoreanRegular(size: size)
        }
    }
    
    static func customKoreanRegular(size: CGFloat) -> Font {
        return Font.system(size: size, weight: .regular)
    }
    
    static func customKoreanBold(size: CGFloat) -> Font {
        return Font.system(size: size, weight: .bold)
    }
    
    // MARK: - Dynamic Type Support for Korean
    static func koreanDynamic(_ textStyle: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        return Font.system(textStyle, design: .default, weight: weight)
    }
    
    private static func dynamicSize(for textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .body: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        @unknown default: return 17
        }
    }
}

// MARK: - View Modifier for Korean Text
struct KoreanTextModifier: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.koreanFont(size, weight: weight))
    }
}

extension View {
    func koreanText(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(KoreanTextModifier(size: size, weight: weight))
    }
}