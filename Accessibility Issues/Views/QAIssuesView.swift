import SwiftUI

struct QAIssuesView: View {
    @State private var executedOrderDisplay = false
    @State private var dynamicButtonAccessible = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // TE-133 QA Test Cases - iOS Accessibility Role Check
                VStack(alignment: .leading, spacing: 20) {
                    Text("TE-133: iOS Accessibility Role Check")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Test cases for validating the iOS Accessibility Role Label Rule for UIButton (native button element) on iPhone devices.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-07: UIButton with Accessibility Traits Cleared (VIOLATION)
                        Group {
                            Text("TC-07: Traits Cleared")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("accessibilityTraits = .none - No Button role announced")
                                .font(.caption)
                            Button(action: {}) {
                                Text("No Role Button")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityRemoveTraits(.isButton)
                            .accessibilityAddTraits([])
                            .accessibilityIdentifier("tc07_no_role_button")
                            Text("⚠️ VIOLATION: Element missing button role")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: UIButton with Label but No Role Announcement (VIOLATION)
                        Group {
                            Text("TC-08: Label but No Role")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("accessibilityTraits = .none with explicit label - No Button role announced")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityRemoveTraits(.isButton)
                            .accessibilityAddTraits([])
                            .accessibilityLabel("Submit")
                            .accessibilityIdentifier("tc08_no_role_labeled_button")
                            Text("⚠️ VIOLATION: VoiceOver says \"Submit\" with no Button role")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Positive Test Cases (VALID)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Positive Test Cases (VALID)")
                            .font(.headline)
                            .foregroundColor(Color(red: 0, green: 0.5, blue: 0))

                        // TC-01: UIButton with Default Accessible Value
                        Group {
                            Text("TC-01: UIButton with Default Accessible Value")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Default accessible=true, implicit Button role via traits")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Default Button")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityIdentifier("tc01_default_button")
                        }

                        Divider()

                        // TC-02: UIButton with Explicit accessible=false
                        Group {
                            Text("TC-02: UIButton with accessible=false")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver should NOT announce this element")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Hidden from A11y")
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityHidden(true)
                            .accessibilityIdentifier("tc02_hidden_button")
                        }

                        Divider()

                        // TC-03: UIButton with Label and Role (VALID)
                        Group {
                            Text("TC-03: UIButton with Label and Role")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver announces: \"Submit Form, Button\"")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit Form")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit Form")
                            .accessibilityIdentifier("tc03_labeled_button")
                        }

                        Divider()

                        // TC-04: UIButton - Visible + Hittable + Accessible (VALID)
                        Group {
                            Text("TC-04: Visible + Hittable + Accessible")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("visible=true, hittable=true, accessible=true, implicit role")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Interactive Button")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .opacity(1)
                            .disabled(false)
                            .allowsHitTesting(true)
                            .accessibilityHidden(false)
                            .accessibilityIdentifier("tc04_interactive_button")
                        }

                        Divider()

                        // TC-05: Disabled UIButton (enabled=false)
                        Group {
                            Text("TC-05: Disabled UIButton")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver announces: \"Save Changes, Button, Dimmed\"")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Save Changes")
                                    .padding()
                                    .background(Color.blue.opacity(0.5))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(true)
                            .accessibilityLabel("Save Changes")
                            .accessibilityIdentifier("tc05_disabled_button")
                        }

                        Divider()

                        // TC-06: UIButton State Change (Dynamic)
                        Group {
                            Text("TC-06: Dynamic State Change")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle accessible state dynamically")
                                .font(.caption)

                            HStack {
                                Button(action: {}) {
                                    Text("Dynamic Button")
                                        .padding()
                                        .background(dynamicButtonAccessible ? Color.blue : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityHidden(!dynamicButtonAccessible)
                                .accessibilityIdentifier("tc06_dynamic_button")

                                Toggle("Accessible", isOn: $dynamicButtonAccessible)
                                    .labelsHidden()
                                    .accessibilityLabel("Toggle Button Accessibility")
                            }
                            Text("Current state: accessible=\(dynamicButtonAccessible ? "true" : "false")")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                }
                .padding()

            }
            .padding()
        }
        .navigationTitle("")
    }
}

#Preview {
    NavigationView {
        QAIssuesView()
    }
}
