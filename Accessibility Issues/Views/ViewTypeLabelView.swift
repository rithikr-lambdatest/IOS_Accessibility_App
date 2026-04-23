import SwiftUI

struct ViewTypeLabelView: View {
    @State private var darkModeSwitch = true
    @State private var darkModeToggle = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // AT-882: View Type in Accessibility Labels
                VStack(alignment: .leading, spacing: 20) {
                    Text("AT-882: View Type in Labels")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Detects redundant element type keywords in accessibility labels that VoiceOver already announces automatically, causing double announcements like \"Submit button, button\".")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Button with "button" in label
                        Group {
                            Text("TC-01: Button Label Contains \"button\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with \"Submit button\" — VoiceOver already announces \"button\" for UIButton")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit button")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit button")
                            .accessibilityIdentifier("tc01_type_button_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Submit button, button\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Switch with "switch" in label
                        Group {
                            Text("TC-02: Switch Label Contains \"switch\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle with \"Dark Mode Switch\" — VoiceOver already announces \"switch button\"")
                                .font(.caption)
                            Toggle(isOn: $darkModeSwitch) {
                                Text("Dark Mode Switch")
                            }
                            .accessibilityLabel("Dark Mode Switch")
                            .accessibilityIdentifier("tc02_type_switch_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Dark Mode Switch, switch button\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Image with "image" in label
                        Group {
                            Text("TC-03: Image Label Contains \"image\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image with \"Profile image\" — VoiceOver already announces \"image\"")
                                .font(.caption)
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .accessibilityLabel("Profile image")
                                .accessibilityIdentifier("tc03_type_image_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Profile image, image\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Link with "link" in label
                        Group {
                            Text("TC-04: Link Label Contains \"link\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with \"Privacy Policy link\" — VoiceOver already announces \"link\"")
                                .font(.caption)
                            Button("Privacy Policy link") {}
                                .accessibilityAddTraits(.isLink)
                                .accessibilityLabel("Privacy Policy link")
                                .accessibilityIdentifier("tc04_type_link_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Privacy Policy link, link\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: Button with "heading" in label (header trait)
                        Group {
                            Text("TC-05: Header Label Contains \"heading\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Header element with \"Settings heading\" — VoiceOver already announces \"heading\"")
                                .font(.caption)
                            Text("Settings heading")
                                .font(.title2)
                                .fontWeight(.bold)
                                .accessibilityAddTraits(.isHeader)
                                .accessibilityLabel("Settings heading")
                                .accessibilityIdentifier("tc05_type_heading_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Settings heading, heading\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-06: TextField with "text field" in label
                        Group {
                            Text("TC-06: TextField Label Contains \"text field\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("TextField with \"Email text field\" — VoiceOver already announces \"text field\"")
                                .font(.caption)
                            TextField("Email", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .accessibilityLabel("Email text field")
                                .accessibilityIdentifier("tc06_type_textfield_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Email text field, text field\" — redundant type")
                                .font(.caption)
                        }
                        Divider()

                        // TC-07: Slider with "adjustable" in label
                        Group {
                            Text("TC-07: Slider Label Contains \"adjustable\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Slider with \"Volume adjustable\" — VoiceOver already announces \"adjustable\" for Slider")
                                .font(.caption)
                            Slider(value: .constant(0.5))
                                .accessibilityLabel("Volume adjustable")
                                .accessibilityIdentifier("tc07_type_adjustable_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Volume adjustable, adjustable\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Stepper with "stepper" in label
                        Group {
                            Text("TC-08: Stepper Label Contains \"stepper\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Stepper with \"Quantity stepper\" — VoiceOver already announces \"stepper\"")
                                .font(.caption)
                            Stepper(value: .constant(1), in: 0...10) {
                                Text("Quantity stepper")
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Quantity stepper")
                            .accessibilityIdentifier("tc08_type_stepper_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Quantity stepper, stepper\" — redundant type")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: SearchField with "search field" in label
                        Group {
                            Text("TC-09: SearchField Label Contains \"search field\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Search field with \"Product search field\" — VoiceOver already announces \"search field\"")
                                .font(.caption)
                            TextField("Search products", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .accessibilityAddTraits(.isSearchField)
                                .accessibilityLabel("Product search field")
                                .accessibilityIdentifier("tc09_type_searchfield_in_label")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Product search field, search field\" — redundant type")
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

                        // TC-10: Slider with "slider" (VO says "adjustable")
                        Group {
                            Text("TC-10: Slider Label Contains \"slider\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver says \"adjustable\" not \"slider\" — so \"slider\" in label is not redundant")
                                .font(.caption)
                            Slider(value: .constant(0.5))
                                .accessibilityLabel("Volume Slider")
                                .accessibilityIdentifier("tc10_slider_not_flagged")
                            Text("✅ PASS: VoiceOver says \"adjustable\" not \"slider\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: Switch with "toggle" (VO says "switch button")
                        Group {
                            Text("TC-11: Switch Label Contains \"toggle\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver says \"switch button\" not \"toggle\" — so \"toggle\" in label is not redundant")
                                .font(.caption)
                            Toggle(isOn: $darkModeToggle) {
                                Text("Dark Mode Toggle")
                            }
                            .accessibilityLabel("Dark Mode Toggle")
                            .accessibilityIdentifier("tc11_toggle_not_flagged")
                            Text("✅ PASS: VoiceOver says \"switch button\" not \"toggle\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-12: Picker with "picker" (VO says "button")
                        Group {
                            Text("TC-12: Picker Label Contains \"picker\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver says \"button\" not \"picker\" — so \"picker\" in label is not redundant")
                                .font(.caption)
                            Picker("Color picker", selection: .constant(0)) {
                                Text("Red").tag(0)
                                Text("Blue").tag(1)
                            }
                            .accessibilityLabel("Color picker")
                            .accessibilityIdentifier("tc12_picker_not_flagged")
                            Text("✅ PASS: VoiceOver says \"button\" not \"picker\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-13: Button with "tab" (VO says "button")
                        Group {
                            Text("TC-13: Button Label Contains \"tab\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver says \"button\" not \"tab\" — so \"tab\" in label is not redundant")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Home tab")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Home tab")
                            .accessibilityIdentifier("tc13_tab_not_flagged")
                            Text("✅ PASS: VoiceOver says \"button\" not \"tab\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-14: Image with clean label (no "image" keyword)
                        Group {
                            Text("TC-14: Image with Clean Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image with descriptive label that doesn't include the word \"image\"")
                                .font(.caption)
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .accessibilityLabel("User profile photo")
                                .accessibilityIdentifier("tc14_image_clean_label")
                            Text("✅ PASS: Label describes content without redundant \"image\" keyword")
                                .font(.caption)
                        }

                        Divider()

                        // TC-15: Clean button label
                        Group {
                            Text("TC-15: Clean Button Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with a clean label containing no type keywords")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit Form")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit Form")
                            .accessibilityIdentifier("tc15_clean_button_label")
                            Text("✅ PASS: Label contains no type keywords")
                                .font(.caption)
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
        ViewTypeLabelView()
    }
}
