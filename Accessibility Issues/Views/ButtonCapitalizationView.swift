import SwiftUI

struct ButtonCapitalizationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Button Element Capitalization")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures accessibility labels for button elements begin with an uppercase letter. Screen readers depend on proper capitalization to pronounce labels correctly.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Button with lowercase label
                        Group {
                            Text("TC-01: Button with Lowercase Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button label starts with lowercase — screen reader may mispronounce")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("submit user details")
                            .accessibilityIdentifier("tc01_button_lowercase_label")
                        }

                        Divider()

                        // TC-02: Icon button with lowercase label
                        Group {
                            Text("TC-02: Icon Button with Lowercase Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon button label starts with lowercase letter")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "trash")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("delete item")
                            .accessibilityIdentifier("tc02_icon_button_lowercase_label")
                        }

                        Divider()

                        // TC-03: Link with lowercase label
                        Group {
                            Text("TC-03: Link with Lowercase Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link label starts with lowercase letter")
                                .font(.caption)
                            Button("Learn More") {}
                                .accessibilityAddTraits(.isLink)
                                .accessibilityLabel("learn more about pricing")
                                .accessibilityIdentifier("tc03_link_lowercase_label")
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

                        // TC-04: Button with uppercase label
                        Group {
                            Text("TC-04: Button with Uppercase Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button label starts with uppercase letter")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit User Details")
                            .accessibilityIdentifier("tc04_button_uppercase_label")
                        }

                        Divider()

                        // TC-05: Icon button with uppercase label
                        Group {
                            Text("TC-05: Icon Button with Uppercase Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon button label starts with uppercase letter")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "trash")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Delete Item")
                            .accessibilityIdentifier("tc05_icon_button_uppercase_label")
                        }

                        Divider()

                        // TC-06: Link with uppercase label
                        Group {
                            Text("TC-06: Link with Uppercase Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link label starts with uppercase letter")
                                .font(.caption)
                            Button("Learn More") {}
                                .accessibilityAddTraits(.isLink)
                                .accessibilityLabel("Learn More About Pricing")
                                .accessibilityIdentifier("tc06_link_uppercase_label")
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
        ButtonCapitalizationView()
    }
}
