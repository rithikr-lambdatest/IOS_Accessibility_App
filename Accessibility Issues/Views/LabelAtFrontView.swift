import SwiftUI

struct LabelAtFrontView: View {
    @State private var notifications = true
    @State private var darkMode = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // HACK-201: Label at Front
                VStack(alignment: .leading, spacing: 20) {
                    Text("HACK-201: Label at Front")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Visible text should be at the beginning of the accessibility label. Screen readers announce labels from the start — extra text before the visible label confuses users and breaks speech recognition.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Visible text not at front of label
                        Group {
                            Text("TC-01: Visible Text Not at Front")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Submit\" but accessibility label is \"Form Submit Button\" — visible text not at start")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Form Submit Button")
                            .accessibilityIdentifier("tc01_label_not_at_front")
                            Text("⚠️ VIOLATION: Label starts with \"Form\" not \"Submit\" — move visible text to front")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Visible text buried in middle of label
                        Group {
                            Text("TC-02: Visible Text in Middle")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Save\" but accessibility label is \"Click Save Changes\" — visible text in middle")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Save")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Click Save Changes")
                            .accessibilityIdentifier("tc02_text_in_middle")
                            Text("⚠️ VIOLATION: Label starts with \"Click\" not \"Save\" — visible text not at front")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Visible text at end of label
                        Group {
                            Text("TC-03: Visible Text at End")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link shows \"Learn More\" but accessibility label is \"Click here to Learn More\" — visible text at end")
                                .font(.caption)
                            Link("Learn More", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Click here to Learn More")
                                .accessibilityIdentifier("tc03_text_at_end")
                            Text("⚠️ VIOLATION: Label starts with \"Click\" not \"Learn More\" — visible text at end")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Toggle with prefix before visible text
                        Group {
                            Text("TC-04: Toggle with Prefix Before Visible Text")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle shows \"Notifications\" but accessibility label is \"Enable Notifications\" — prefix added")
                                .font(.caption)
                            Toggle(isOn: $notifications) {
                                Text("Notifications")
                            }
                            .accessibilityLabel("Enable Notifications")
                            .accessibilityIdentifier("tc04_toggle_prefix_before_text")
                            Text("⚠️ VIOLATION: Label starts with \"Enable\" not \"Notifications\" — visible text not at front")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: Button with action verb prefix
                        Group {
                            Text("TC-05: Action Verb Prefix")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Order\" but accessibility label is \"Place Order Now\" — action verb before visible text")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Order")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Place Order Now")
                            .accessibilityIdentifier("tc05_action_verb_prefix")
                            Text("⚠️ VIOLATION: Label starts with \"Place\" not \"Order\" — visible text not at front")
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

                        // TC-06: Visible text at front — exact match
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
                            .accessibilityIdentifier("tc06_exact_match_front")
                            Text("✅ PASS: Visible text \"Submit\" is at the front of accessibility label")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Visible text at front with additional context
                        Group {
                            Text("TC-07: Visible Text at Front with Context (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Submit\" and accessibility label is \"Submit Order\" — visible text at start")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Submit")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Submit Order")
                            .accessibilityIdentifier("tc07_text_at_front_with_context")
                            Text("✅ PASS: Label starts with visible text \"Submit\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Link with visible text at front
                        Group {
                            Text("TC-08: Link with Text at Front (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link shows \"Privacy Policy\" and label is \"Privacy Policy details\"")
                                .font(.caption)
                            Link("Privacy Policy", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Privacy Policy details")
                                .accessibilityIdentifier("tc08_link_text_at_front")
                            Text("✅ PASS: Label starts with visible text \"Privacy Policy\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: Toggle with visible text at front
                        Group {
                            Text("TC-09: Toggle with Text at Front (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle shows \"Dark Mode\" and label is \"Dark Mode toggle\"")
                                .font(.caption)
                            Toggle(isOn: $darkMode) {
                                Text("Dark Mode")
                            }
                            .accessibilityLabel("Dark Mode toggle")
                            .accessibilityIdentifier("tc09_toggle_text_at_front")
                            Text("✅ PASS: Label starts with visible text \"Dark Mode\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Button with visible text at front and suffix
                        Group {
                            Text("TC-10: Visible Text at Front with Suffix (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button shows \"Delete\" and label is \"Delete all items\" — visible text leads")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Delete")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Delete all items")
                            .accessibilityIdentifier("tc10_text_at_front_with_suffix")
                            Text("✅ PASS: Label starts with visible text \"Delete\"")
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

                        Text("These elements should be skipped by the Label at Front check — no violation should be reported.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-11: Icon-only button (no visible text)
                        Group {
                            Text("TC-11: Icon-Only Button — No Visible Text (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button has only an icon, no visible text to check position — check should be skipped")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Add new item")
                            .accessibilityIdentifier("tc11_icon_only_no_visible_text")
                            Text("⏭️ SKIP: No visible text to check position — icon-only element")
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
                                Text("Save")
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
                            Text("Image element with no visible text — no position to check")
                                .font(.caption)
                            Image(systemName: "heart.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .accessibilityLabel("Liked")
                                .accessibilityIdentifier("tc13_image_no_visible_text")
                            Text("⏭️ SKIP: No visible text on image — icon-only element")
                                .font(.caption)
                        }

                        Divider()

                        // TC-14: SF Symbol button (no visible text, low OCR confidence)
                        Group {
                            Text("TC-14: SF Symbol Button — Low OCR Confidence (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button uses SF Symbol icon only — OCR won't find readable text")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Share")
                            .accessibilityIdentifier("tc14_sf_symbol_low_ocr_confidence")
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
        LabelAtFrontView()
    }
}
