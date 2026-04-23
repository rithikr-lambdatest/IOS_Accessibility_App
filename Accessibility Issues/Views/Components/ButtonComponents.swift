import SwiftUI

// Button WITHOUT proper accessibility traits (demonstrates the issue)
// Using a native Button but REMOVING its traits
struct CustomButtonNoTraits: View {
    let title: String
    @Binding var actionPerformed: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                actionPerformed = true
            }
            // Reset after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    actionPerformed = false
                }
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(actionPerformed ? Color.green : Color.blue)
                )
        }
        .buttonStyle(.plain)
        .accessibilityRemoveTraits(.isButton) // REMOVING the button trait!
        // VoiceOver now only reads the text without announcing it's a button
        // This creates the exact issue shown in the debug screenshot
    }
}

// Button WITH proper accessibility traits (correct implementation)
struct CustomButtonWithTraits: View {
    let title: String
    @Binding var actionPerformed: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                actionPerformed = true
            }
            // Reset after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    actionPerformed = false
                }
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(actionPerformed ? Color.green : Color.blue)
                )
        }
        .buttonStyle(.plain)
        // Native Button automatically has proper accessibility traits
        // We keep the default traits - VoiceOver announces it as a button
    }
}

// Alternative: Fully customized with explicit traits
struct NativeButton: View {
    let title: String
    @Binding var actionPerformed: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                actionPerformed = true
            }
            // Reset after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    actionPerformed = false
                }
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(actionPerformed ? Color.green : Color.blue)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint("Double tap to activate")
        // Explicitly adding traits for complete control
    }
}

#Preview {
    @Previewable @State var action1 = false
    @Previewable @State var action2 = false
    @Previewable @State var action3 = false
    
    VStack(spacing: 30) {
        Text("Missing Button Trait")
            .font(.caption)
            .foregroundColor(.red)
        CustomButtonNoTraits(title: "Update Profile", actionPerformed: $action1)
        if action1 {
            Text("✓ Action Performed!")
                .foregroundColor(.green)
                .font(.caption)
        }
        
        Divider()
        
        Text("With Button Trait")
            .font(.caption)
            .foregroundColor(.green)
        CustomButtonWithTraits(title: "Update Profile", actionPerformed: $action2)
        if action2 {
            Text("✓ Action Performed!")
                .foregroundColor(.green)
                .font(.caption)
        }
        
        Divider()
        
        Text("Native Button (Always Correct)")
            .font(.caption)
            .foregroundColor(.green)
        NativeButton(title: "Update Profile", actionPerformed: $action3)
        if action3 {
            Text("✓ Action Performed!")
                .foregroundColor(.green)
                .font(.caption)
        }
    }
    .padding()
}
