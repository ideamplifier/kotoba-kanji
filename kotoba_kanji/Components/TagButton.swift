import SwiftUI

// MARK: - Tag Button Component
struct TagButton: View {
    let title: String
    @Binding var searchText: String
    @State private var isPressed = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)) {
                searchText = title
            }
            HapticManager.shared.impact(.light, intensity: 0.6)
        }) {
            Text(title)
                .font(StyleConstants.Typography.koreanDynamic(.callout, weight: .medium))
                .foregroundColor(isPressed ? .white : Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(isPressed ? Color.blue.opacity(0.8) : StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isPressed ? Color.blue.opacity(0.8) : StyleConstants.Colors.adaptiveDivider(colorScheme), lineWidth: 1)
                )
                .cornerRadius(16)
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
        .accessibilityLabel("\(title) 태그")
        .accessibilityHint("\(title)로 검색합니다")
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Category Tag Button Component
struct CategoryTagButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(StyleConstants.Typography.koreanDynamic(.caption, weight: .medium))
                .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(minWidth: 70, minHeight: 44)
                .background(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(StyleConstants.Colors.adaptiveDivider(colorScheme), lineWidth: 1)
                )
                .cornerRadius(14)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(title) 카테고리")
        .accessibilityHint("\(title) 카테고리로 이동합니다")
        .accessibilityAddTraits(.isButton)
    }
} 
