import SwiftUI

struct LabelInNameView: View {
    @State private var tc03DarkMode = true
    @State private var tc09Notifications = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // TE-2497: Label in Name
                VStack(alignment: .leading, spacing: 20) {
                    Text("TE-2497: Label in Name")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Visible text of a UI component must be contained in its accessibility label. Speech recognition users say visible labels to activate controls — if the accessible name differs, voice commands fail.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Button visible text not in accessibility label
                        Group {
                            Text("TC-01: Visible Text Not in Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Submit\" but accessibility label is \"Send form\" — voice command \"click Submit\" fails")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Send form")
                            .accessibilityIdentifier("tc01_label_not_in_name")
                            Text("⚠️ VIOLATION: Visible text \"Submit\" not found in accessibility label \"Send form\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Link visible text not in accessibility label
                        Group {
                            Text("TC-02: Link Text Not in Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link shows \"Learn More\" but accessibility label is \"Additional information\" — mismatch")
                                .font(.caption)
                            Link("Learn More", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Additional information")
                                .accessibilityIdentifier("tc02_link_label_not_in_name")
                            Text("⚠️ VIOLATION: Visible text \"Learn More\" not found in accessibility label \"Additional information\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Toggle visible text not in accessibility label
                        Group {
                            Text("TC-03: Toggle Text Not in Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle shows \"Dark Mode\" but accessibility label is \"Theme switcher\"")
                                .font(.caption)
                            Toggle(isOn: $tc03DarkMode) {
                                Text("Dark Mode")
                            }
                            .accessibilityLabel("Theme switcher")
                            .accessibilityIdentifier("tc03_toggle_label_not_in_name")
                            Text("⚠️ VIOLATION: Visible text \"Dark Mode\" not found in accessibility label \"Theme switcher\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Button with completely different label
                        Group {
                            Text("TC-04: Completely Different Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Cancel\" but accessibility label is \"Go back\" — no overlap")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Cancel")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Go back")
                            .accessibilityIdentifier("tc04_completely_different_label")
                            Text("⚠️ VIOLATION: Visible text \"Cancel\" not found in accessibility label \"Go back\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: Button with partial mismatch
                        Group {
                            Text("TC-05: Partial Word Mismatch")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Sign Up\" but accessibility label is \"Register account\" — partial mismatch")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Sign Up")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Register account")
                            .accessibilityIdentifier("tc05_partial_mismatch")
                            Text("⚠️ VIOLATION: Visible text \"Sign Up\" not found in accessibility label \"Register account\"")
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

                        // TC-06: Visible text matches accessibility label exactly
                        Group {
                            Text("TC-06: Exact Match (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Submit\" and accessibility label is \"Submit\" — exact match")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit")
                            .accessibilityIdentifier("tc06_exact_match")
                            Text("✅ PASS: Visible text \"Submit\" matches accessibility label")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Visible text contained in longer accessibility label
                        Group {
                            Text("TC-07: Visible Text Contained in Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Submit\" and accessibility label is \"Submit Order\" — visible text is contained")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit Order")
                            .accessibilityIdentifier("tc07_text_contained_in_label")
                            Text("✅ PASS: Visible text \"Submit\" is contained in accessibility label \"Submit Order\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Link with matching label
                        Group {
                            Text("TC-08: Link with Matching Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link shows \"Privacy Policy\" and accessibility label contains the same text")
                                .font(.caption)
                            Link("Privacy Policy", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Privacy Policy")
                                .accessibilityIdentifier("tc08_link_matching_label")
                            Text("✅ PASS: Visible text matches accessibility label")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: Toggle with matching label
                        Group {
                            Text("TC-09: Toggle with Matching Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle shows \"Notifications\" and accessibility label is \"Notifications\"")
                                .font(.caption)
                            Toggle(isOn: $tc09Notifications) {
                                Text("Notifications")
                            }
                            .accessibilityLabel("Notifications")
                            .accessibilityIdentifier("tc09_toggle_matching_label")
                            Text("✅ PASS: Visible text matches accessibility label")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Button with extended label containing visible text
                        Group {
                            Text("TC-10: Extended Label Contains Visible Text (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Delete\" and accessibility label is \"Delete all items\" — visible text included")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Delete")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Delete all items")
                            .accessibilityIdentifier("tc10_extended_label_contains_text")
                            Text("✅ PASS: Visible text \"Delete\" is contained in accessibility label \"Delete all items\"")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Skip Condition Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Skip Condition Test Cases")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("These elements should be skipped by the Label in Name check — no violation should be reported.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-11: Icon-only button (no visible text)
                        Group {
                            Text("TC-11: Icon-Only Button — No Visible Text (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button has only an icon, no visible text to compare — check should be skipped")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "trash")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Delete item")
                            .accessibilityIdentifier("tc11_icon_only_no_visible_text")
                            Text("⏭️ SKIP: No visible text to compare — icon-only element")
                                .font(.caption)
                        }

                        Divider()

                        // TC-12: Element hidden from accessibility (accessible=false)
                        Group {
                            Text("TC-12: Element Hidden from Accessibility (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button is hidden from VoiceOver via accessibilityHidden — check should be skipped")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityHidden(true)
                            .accessibilityIdentifier("tc12_accessible_false")
                            Text("⏭️ SKIP: Element has accessible=false — not exposed to assistive technology")
                                .font(.caption)
                        }

                        Divider()

                        // TC-13: Decorative image (no visible text)
                        Group {
                            Text("TC-13: Decorative Image — No Visible Text (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image element with no visible text — nothing to compare against label")
                                .font(.caption)
                            Image(systemName: "star.fill")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                                .accessibilityLabel("Favorite")
                                .accessibilityIdentifier("tc13_image_no_visible_text")
                            Text("⏭️ SKIP: No visible text on image — icon-only element")
                                .font(.caption)
                        }

                        Divider()

                        // TC-14: Icon button with SF Symbol (no visible text)
                        Group {
                            Text("TC-14: SF Symbol Button — No Visible Text (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button uses SF Symbol icon only — OCR won't find readable text")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "gear")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Settings")
                            .accessibilityIdentifier("tc14_sf_symbol_no_visible_text")
                            Text("⏭️ SKIP: No visible text — SF Symbol icon only, OCR confidence below threshold")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
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
        LabelInNameView()
    }
}
