import SwiftUI

struct CheckboxElementLabelView: View {
    @State private var isChecked1 = false
    @State private var isChecked2 = true
    @State private var isChecked3 = false
    @State private var isChecked4 = true
    @State private var isChecked5 = false
    @State private var isChecked6 = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Checkbox Element Accessibility Label")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures checkbox elements are properly labeled and fully accessible to users relying on assistive technologies like screen readers. Both the checkbox name and value must be communicated.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Checkbox with no label
                        Group {
                            Text("TC-01: Checkbox with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle styled as checkbox with empty accessibility label")
                                .font(.caption)
                            Toggle(isOn: $isChecked1) {
                                EmptyView()
                            }
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc01_checkbox_no_label")
                        }

                        Divider()

                        // TC-02: Checkbox button with no label
                        Group {
                            Text("TC-02: Checkbox Button with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button acting as checkbox with empty accessibility label")
                                .font(.caption)
                            Button(action: { isChecked2.toggle() }) {
                                Image(systemName: isChecked2 ? "checkmark.square.fill" : "square")
                                    .font(.title2)
                                    .foregroundColor(isChecked2 ? .blue : .gray)
                            }
                            .accessibilityAddTraits(.isToggle)
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc02_checkbox_button_no_label")
                        }

                        Divider()

                        // TC-03: Checkbox with label and text but no accessibility label
                        Group {
                            Text("TC-03: Checkbox with Visible Text but No Accessibility Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Checkbox has visible text but empty accessibility label override")
                                .font(.caption)
                            HStack {
                                Button(action: { isChecked3.toggle() }) {
                                    Image(systemName: isChecked3 ? "checkmark.square.fill" : "square")
                                        .font(.title2)
                                        .foregroundColor(isChecked3 ? .blue : .gray)
                                }
                                Text("Accept Terms")
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityAddTraits(.isToggle)
                            .accessibilityLabel("")
                            .accessibilityIdentifier("tc03_checkbox_text_no_label")
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

                        // TC-04: Toggle checkbox with descriptive label
                        Group {
                            Text("TC-04: Checkbox with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle styled as checkbox with clear accessibility label")
                                .font(.caption)
                            Toggle(isOn: $isChecked4) {
                                EmptyView()
                            }
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .accessibilityLabel("Enable Notifications")
                            .accessibilityIdentifier("tc04_checkbox_with_label")
                        }

                        Divider()

                        // TC-05: Checkbox button with descriptive label
                        Group {
                            Text("TC-05: Checkbox Button with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button acting as checkbox with descriptive accessibility label")
                                .font(.caption)
                            Button(action: { isChecked5.toggle() }) {
                                Image(systemName: isChecked5 ? "checkmark.square.fill" : "square")
                                    .font(.title2)
                                    .foregroundColor(isChecked5 ? .blue : .gray)
                            }
                            .accessibilityAddTraits(.isToggle)
                            .accessibilityLabel("Remember Me")
                            .accessibilityIdentifier("tc05_checkbox_button_with_label")
                        }

                        Divider()

                        // TC-06: Combined checkbox with descriptive label
                        Group {
                            Text("TC-06: Checkbox with Combined Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Checkbox with visible text and proper accessibility label")
                                .font(.caption)
                            HStack {
                                Button(action: { isChecked6.toggle() }) {
                                    Image(systemName: isChecked6 ? "checkmark.square.fill" : "square")
                                        .font(.title2)
                                        .foregroundColor(isChecked6 ? .blue : .gray)
                                }
                                Text("Accept Terms and Conditions")
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityAddTraits(.isToggle)
                            .accessibilityLabel("Accept Terms and Conditions")
                            .accessibilityIdentifier("tc06_checkbox_combined_label")
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
        CheckboxElementLabelView()
    }
}
