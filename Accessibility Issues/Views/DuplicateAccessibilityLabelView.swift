import SwiftUI

struct DuplicateAccessibilityLabelView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Duplicate Accessibility Label")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Identifies when multiple UI elements on the same screen share identical accessibility labels, creating confusion for users relying on screen readers and voice control.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Two buttons with same label
                        Group {
                            Text("TC-01: Two Buttons with Same Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Both buttons share the same accessibility label \"Submit\"")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Button(action: {}) {
                                    Text("Submit Form")
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Submit")
                                .accessibilityIdentifier("tc01_button_duplicate_1")

                                Button(action: {}) {
                                    Text("Submit Order")
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Submit")
                                .accessibilityIdentifier("tc01_button_duplicate_2")
                            }
                        }

                        Divider()

                        // TC-02: Two icon buttons with same label
                        Group {
                            Text("TC-02: Two Icon Buttons with Same Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Both icon buttons share the label \"Delete\"")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Button(action: {}) {
                                    Image(systemName: "trash")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Delete")
                                .accessibilityIdentifier("tc02_icon_duplicate_1")

                                Button(action: {}) {
                                    Image(systemName: "trash.fill")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Delete")
                                .accessibilityIdentifier("tc02_icon_duplicate_2")
                            }
                        }

                        Divider()

                        // TC-03: Image and button with same label
                        Group {
                            Text("TC-03: Image and Button with Same Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("An image and a button both share the label \"Settings\"")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.red)
                                    .accessibilityLabel("Settings")
                                    .accessibilityIdentifier("tc03_image_duplicate")

                                Button(action: {}) {
                                    Image(systemName: "gear")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Settings")
                                .accessibilityIdentifier("tc03_button_duplicate")
                            }
                        }
                        Divider()

                        // TC-04: Two links with same label
                        Group {
                            Text("TC-04: Two Links with Same Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Both links share the same accessibility label \"Learn More\"")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Button("Learn More") {}
                                    .accessibilityAddTraits(.isLink)
                                    .accessibilityLabel("Learn More")
                                    .accessibilityIdentifier("tc04_link_duplicate_1")

                                Button("Learn More") {}
                                    .accessibilityAddTraits(.isLink)
                                    .accessibilityLabel("Learn More")
                                    .accessibilityIdentifier("tc04_link_duplicate_2")
                            }
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

                        // TC-05: Two buttons with unique labels
                        Group {
                            Text("TC-05: Two Buttons with Unique Labels (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Each button has a distinct accessibility label")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Button(action: {}) {
                                    Text("Submit Form")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Submit Registration Form")
                                .accessibilityIdentifier("tc05_button_unique_1")

                                Button(action: {}) {
                                    Text("Submit Order")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Submit Purchase Order")
                                .accessibilityIdentifier("tc05_button_unique_2")
                            }
                        }

                        Divider()

                        // TC-06: Two icon buttons with unique labels
                        Group {
                            Text("TC-06: Two Icon Buttons with Unique Labels (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Each icon button has a distinct accessibility label")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Button(action: {}) {
                                    Image(systemName: "trash")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Delete Message")
                                .accessibilityIdentifier("tc06_icon_unique_1")

                                Button(action: {}) {
                                    Image(systemName: "trash.fill")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Delete Account")
                                .accessibilityIdentifier("tc06_icon_unique_2")
                            }
                        }

                        Divider()

                        // TC-07: Image and button with unique labels
                        Group {
                            Text("TC-07: Image and Button with Unique Labels (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image and button have distinct accessibility labels")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("Settings Icon")
                                    .accessibilityIdentifier("tc07_image_unique")

                                Button(action: {}) {
                                    Image(systemName: "gear")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("Open Settings")
                                .accessibilityIdentifier("tc07_button_unique")
                            }
                        }

                        Divider()

                        // TC-08: Two links with unique labels
                        Group {
                            Text("TC-08: Two Links with Unique Labels (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Each link has a distinct accessibility label")
                                .font(.caption)
                            HStack(spacing: 15) {
                                Button("Learn More") {}
                                    .accessibilityAddTraits(.isLink)
                                    .accessibilityLabel("Learn More About Pricing")
                                    .accessibilityIdentifier("tc08_link_unique_1")

                                Button("Learn More") {}
                                    .accessibilityAddTraits(.isLink)
                                    .accessibilityLabel("Learn More About Features")
                                    .accessibilityIdentifier("tc08_link_unique_2")
                            }
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
        DuplicateAccessibilityLabelView()
    }
}
