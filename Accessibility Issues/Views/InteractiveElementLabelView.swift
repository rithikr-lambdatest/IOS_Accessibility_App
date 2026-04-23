import SwiftUI

struct InteractiveElementLabelView: View {
    @State private var tc03ToggleNoLabel = true
    @State private var tc08ToggleWithLabel = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Interactive Element Label")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures all interactive UI elements have non-null, descriptive accessibility labels that screen readers can announce.")
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

                        // TC-03: Toggle with no label
                        Group {
                            Text("TC-03: Toggle with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle switch without any accessibility label")
                                .font(.caption)
                            Toggle(isOn: $tc03ToggleNoLabel) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc03_toggle_no_label")
                        }

                        Divider()

                        // TC-04: Slider with no label
                        Group {
                            Text("TC-04: Slider with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Slider without any accessibility label — screen reader cannot describe what it adjusts")
                                .font(.caption)
                            Slider(value: .constant(0.5))
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc04_slider_no_label")
                        }

                        Divider()

                        // TC-05: Stepper with no label
                        Group {
                            Text("TC-05: Stepper with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Stepper without any accessibility label")
                                .font(.caption)
                            Stepper(value: .constant(1), in: 0...10) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc05_stepper_no_label")
                        }

                        Divider()

                        // TC-06: Link with no label
                        Group {
                            Text("TC-06: Link with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link without any accessibility label — screen reader cannot describe destination")
                                .font(.caption)
                            Button("Visit Website") {}
                                .accessibilityAddTraits(.isLink)
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc06_link_no_label")
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

                        // TC-07: Button with descriptive label
                        Group {
                            Text("TC-07: Button with Descriptive Label (PASS)")
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
                            .accessibilityIdentifier("tc07_button_with_label")
                        }

                        Divider()

                        // TC-08: Toggle with descriptive label
                        Group {
                            Text("TC-08: Toggle with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle with clear accessibility label describing what it controls")
                                .font(.caption)
                            Toggle(isOn: $tc08ToggleWithLabel) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .accessibilityLabel("Dark Mode")
                            .accessibilityIdentifier("tc08_toggle_with_label")
                        }

                        Divider()

                        // TC-09: Slider with descriptive label
                        Group {
                            Text("TC-09: Slider with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Slider with clear accessibility label describing what it adjusts")
                                .font(.caption)
                            Slider(value: .constant(0.5))
                                .accessibilityLabel("Volume")
                                .accessibilityIdentifier("tc09_slider_with_label")
                        }

                        Divider()

                        // TC-10: Link with descriptive label
                        Group {
                            Text("TC-10: Link with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with clear accessibility label describing destination")
                                .font(.caption)
                            Link("Privacy Policy", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Privacy Policy")
                                .accessibilityIdentifier("tc10_link_with_label")
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
        InteractiveElementLabelView()
    }
}
