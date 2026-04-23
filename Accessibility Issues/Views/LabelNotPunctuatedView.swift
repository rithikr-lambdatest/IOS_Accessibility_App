import SwiftUI

struct LabelNotPunctuatedView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Label Not Punctuated")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Accessibility labels should not end with a period. Labels are not full sentences, and a trailing period causes VoiceOver to introduce an unnatural long pause, disrupting the user experience.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Button with period in label
                        Group {
                            Text("TC-01: Button with Period in Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button label ends with a period — causes unnatural VoiceOver pause")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit form.")
                            .accessibilityIdentifier("tc01_button_period_label")
                        }

                        Divider()

                        // TC-02: Icon button with period in label
                        Group {
                            Text("TC-02: Icon Button with Period in Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon button label ends with a period")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "gear")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Open settings,")
                            .accessibilityIdentifier("tc02_icon_button_period_label")
                        }

                        Divider()

                        // TC-03: Image with period in label
                        Group {
                            Text("TC-03: Image with Period in Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image label ends with a period")
                                .font(.caption)
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.red)
                            .accessibilityLabel("Profile photo.")
                            .accessibilityIdentifier("tc03_image_period_label")
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

                        // TC-04: Button without period in label
                        Group {
                            Text("TC-04: Button without Period (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button label without trailing period")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit form")
                            .accessibilityIdentifier("tc04_button_no_period_label")
                        }

                        Divider()

                        // TC-05: Icon button without period in label
                        Group {
                            Text("TC-05: Icon Button without Period (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon button label without trailing period")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "gear")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Open settings")
                            .accessibilityIdentifier("tc05_icon_button_no_period_label")
                        }

                        Divider()

                        // TC-06: Image without period in label
                        Group {
                            Text("TC-06: Image without Period (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image label without trailing period")
                                .font(.caption)
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                            .accessibilityLabel("Profile photo")
                            .accessibilityIdentifier("tc06_image_no_period_label")
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
        LabelNotPunctuatedView()
    }
}
