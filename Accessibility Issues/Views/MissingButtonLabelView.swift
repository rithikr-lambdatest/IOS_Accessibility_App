import SwiftUI

struct MissingButtonLabelView: View {
    @State private var toggleViolation = true
    @State private var togglePositive = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Missing Button Element Label")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures all button elements have descriptive accessibility labels so screen readers can announce their purpose.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Button with no label
                        Group {
                            Text("TC-01: Button with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with empty accessibility label — screen reader cannot announce purpose")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc01_button_no_label")
                        }

                        Divider()

                        // TC-02: Icon button with no label
                        Group {
                            Text("TC-02: Icon Button with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon-only button without any accessibility label set")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "gear")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc02_icon_button_no_label")
                        }

                        Divider()

                        // TC-03: Toggle with no label (traits swapped to button)
                        Group {
                            Text("TC-03: Toggle with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle switch without any accessibility label")
                                .font(.caption)
                            Toggle(isOn: $toggleViolation) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .accessibilityRemoveTraits(.isToggle)
                            .accessibilityAddTraits(.isButton)
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc03_toggle_no_label")
                        }

                        Divider()

                        // TC-04: Link with no label
                        Group {
                            Text("TC-04: Link with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link without any accessibility label — screen reader cannot describe destination")
                                .font(.caption)
                            Button("Visit Website") {}
                                .accessibilityAddTraits(.isLink)
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc04_link_no_label")
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

                        // TC-05: Button with descriptive label
                        Group {
                            Text("TC-05: Button with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with clear, descriptive accessibility label")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Notifications")
                            .accessibilityIdentifier("tc05_button_with_label")
                        }

                        Divider()

                        // TC-06: Toggle with descriptive label (traits swapped to button)
                        Group {
                            Text("TC-06: Toggle with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle with clear accessibility label, traits swapped to button")
                                .font(.caption)
                            Toggle(isOn: $togglePositive) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .accessibilityRemoveTraits(.isToggle)
                            .accessibilityAddTraits(.isButton)
                            .accessibilityLabel("Dark Mode")
                            .accessibilityIdentifier("tc06_toggle_with_label")
                        }

                        Divider()

                        // TC-07: Link with descriptive label
                        Group {
                            Text("TC-07: Link with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with clear accessibility label describing destination")
                                .font(.caption)
                            Link("Privacy Policy", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Privacy Policy")
                                .accessibilityIdentifier("tc07_link_with_label")
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.5, blue: 0).opacity(0.1))
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
        MissingButtonLabelView()
    }
}
