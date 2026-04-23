import SwiftUI

// Simple view WITHOUT switch role (demonstrates the issue)
struct CustomSwitchNoTraits: View {
    @Binding var isOn: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(isOn ? Color.blue : Color.gray)
            .frame(width: 51, height: 31)
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 27, height: 27)
                    .offset(x: isOn ? 10 : -10)
            )
            .onTapGesture {
                withAnimation {
                    isOn.toggle()
                }
            }
        // NO accessibility role/traits - screen reader doesn't know this is a switch!
    }
}

// Simple view WITH switch role (correct implementation)
struct CustomSwitchWithTraits: View {
    @Binding var isOn: Bool
    let label: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(isOn ? Color.blue : Color.gray)
            .frame(width: 51, height: 31)
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 27, height: 27)
                    .offset(x: isOn ? 10 : -10)
            )
            .onTapGesture {
                withAnimation {
                    isOn.toggle()
                }
            }
        // Proper accessibility - declares this element is a switch!
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
        .accessibilityValue(isOn ? "On" : "Off")
        .accessibilityAddTraits([.isButton]) // This declares the role as a switch/toggle
    }
}

#Preview {
    VStack(spacing: 30) {
        CustomSwitchNoTraits(isOn: .constant(false))
        CustomSwitchNoTraits(isOn: .constant(true))
        
        CustomSwitchWithTraits(isOn: .constant(false), label: "Enable feature")
        CustomSwitchWithTraits(isOn: .constant(true), label: "Enable feature")
    }
    .padding()
}
