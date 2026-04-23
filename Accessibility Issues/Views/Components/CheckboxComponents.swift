import SwiftUI

struct CustomCheckbox: View {
    @Binding var isChecked: Bool
    var label: String
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .imageScale(.large)
                if !label.isEmpty {
                    Text(label)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityValue(isChecked ? "checked" : "not checked")
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(label.isEmpty ? "Checkbox" : label)
    }
}

struct CustomCheckboxNoLabel: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .imageScale(.large)
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityValue(isChecked ? "checked" : "not checked")
        .accessibilityAddTraits(.isButton)
        // Deliberately no accessibilityLabel to trigger violation
    }
}

