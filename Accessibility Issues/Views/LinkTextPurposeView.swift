import SwiftUI

struct LinkTextPurposeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Link Text Purpose")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Links must have descriptive text that conveys their purpose. Generic labels like \"click here\" or \"read more\" don't help screen reader users understand the link destination. WCAG 2.4.4 (Level A).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: "Click here" link
                        Group {
                            Text("TC-01: Generic \"Click here\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with generic \"Click here\" text — no context about destination")
                                .font(.caption)
                            Link("Click here", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc01_click_here")
                            Text("VIOLATION: Generic link text \"Click here\" — doesn't describe destination")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: "Read more" link
                        Group {
                            Text("TC-02: Generic \"Read more\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with generic \"Read more\" text — common but non-descriptive")
                                .font(.caption)
                            Link("Read more", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc02_read_more")
                            Text("VIOLATION: Generic link text \"Read more\" — doesn't convey what will be read")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: "Learn more" link
                        Group {
                            Text("TC-03: Generic \"Learn more\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with generic \"Learn more\" text — vague purpose")
                                .font(.caption)
                            Link("Learn more", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc03_learn_more")
                            Text("VIOLATION: Generic link text \"Learn more\" — no context about what to learn")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: "Tap here" link (iOS-specific)
                        Group {
                            Text("TC-04: Generic \"Tap here\" Link (iOS-specific)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with iOS-specific generic \"Tap here\" text")
                                .font(.caption)
                            Link("Tap here", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc04_tap_here")
                            Text("VIOLATION: Generic link text \"Tap here\" — iOS equivalent of \"click here\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: "Tap this" link (iOS-specific)
                        Group {
                            Text("TC-05: Generic \"Tap this\" Link (iOS-specific)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with iOS-specific generic \"Tap this\" text")
                                .font(.caption)
                            Link("Tap this", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc05_tap_this")
                            Text("VIOLATION: Generic link text \"Tap this\" — iOS equivalent of \"click this\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-06: "Here" link
                        Group {
                            Text("TC-06: Generic \"Here\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with single word \"Here\" — most vague possible link text")
                                .font(.caption)
                            Link("Here", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc06_here")
                            Text("VIOLATION: Generic link text \"Here\" — provides zero context")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: "More" link
                        Group {
                            Text("TC-07: Generic \"More\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with single word \"More\" — non-descriptive")
                                .font(.caption)
                            Link("More", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc07_more")
                            Text("VIOLATION: Generic link text \"More\" — doesn't describe what more of")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: "See more" link
                        Group {
                            Text("TC-08: Generic \"See more\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with generic \"See more\" text")
                                .font(.caption)
                            Link("See more", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc08_see_more")
                            Text("VIOLATION: Generic link text \"See more\" — vague purpose")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: "View more" link (iOS-specific)
                        Group {
                            Text("TC-09: Generic \"View more\" Link (iOS-specific)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with iOS-specific generic \"View more\" text")
                                .font(.caption)
                            Link("View more", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc09_view_more")
                            Text("VIOLATION: Generic link text \"View more\" — common iOS generic pattern")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: "Link" text
                        Group {
                            Text("TC-10: Generic \"Link\" Text")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link labeled just \"Link\" — redundant with VoiceOver role announcement")
                                .font(.caption)
                            Link("Link", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc10_link")
                            Text("VIOLATION: Link text \"Link\" — redundant with role, no purpose conveyed")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: "Details" link
                        Group {
                            Text("TC-11: Generic \"Details\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link labeled just \"Details\" — vague alone on a link element")
                                .font(.caption)
                            Link("Details", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc11_details")
                            Text("VIOLATION: Link text \"Details\" — vague without context, only flagged on link elements")
                                .font(.caption)
                        }

                        Divider()

                        // TC-12: "Go" link
                        Group {
                            Text("TC-12: Generic \"Go\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link labeled just \"Go\" — no destination context")
                                .font(.caption)
                            Link("Go", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc12_go")
                            Text("VIOLATION: Link text \"Go\" — doesn't describe where")
                                .font(.caption)
                        }

                        Divider()

                        // TC-13: "Start" link
                        Group {
                            Text("TC-13: Generic \"Start\" Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link labeled just \"Start\" — vague action")
                                .font(.caption)
                            Link("Start", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc13_start")
                            Text("VIOLATION: Link text \"Start\" — doesn't describe what starts")
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

                        // TC-14: Descriptive link text
                        Group {
                            Text("TC-14: Descriptive Link Text (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link clearly describes the destination — \"View pricing details\"")
                                .font(.caption)
                            Link("View pricing details", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc14_descriptive_link")
                            Text("PASS: Link text \"View pricing details\" clearly describes the destination")
                                .font(.caption)
                        }

                        Divider()

                        // TC-15: Descriptive multi-word link
                        Group {
                            Text("TC-15: Multi-Word Descriptive Link (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with 3+ words considered descriptive by the check")
                                .font(.caption)
                            Link("Read our privacy policy", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc15_multiword_descriptive")
                            Text("PASS: 3+ word link text is considered descriptive")
                                .font(.caption)
                        }

                        Divider()

                        // TC-16: Specific action link
                        Group {
                            Text("TC-16: Specific Action Link (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link describes specific action — \"Download annual report\"")
                                .font(.caption)
                            Link("Download annual report", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc16_specific_action")
                            Text("PASS: Link text clearly describes the action and target")
                                .font(.caption)
                        }

                        Divider()

                        // TC-17: Contextual link text
                        Group {
                            Text("TC-17: Contextual Navigation Link (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with context — \"Contact support team\" vs generic \"Contact\"")
                                .font(.caption)
                            Link("Contact support team", destination: URL(string: "https://example.com")!)
                                .accessibilityIdentifier("tc17_contextual_link")
                            Text("PASS: Link text provides meaningful context about destination")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.5, blue: 0).opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Skip Condition Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Skip Condition Test Cases")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("These elements should be skipped by the Link Text Purpose check — no violation should be reported.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-18: Non-link element with generic text (button)
                        Group {
                            Text("TC-18: Non-Link Element — Button with \"More\" (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button (not a link) with \"More\" text — check only applies to link-trait elements")
                                .font(.caption)
                            Button(action: {}) {
                                Text("More")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityIdentifier("tc18_button_not_link")
                            Text("SKIP: Element is a button, not a link — LinkTextPurposeCheck only runs on Link trait elements")
                                .font(.caption)
                        }

                        Divider()

                        // TC-19: Hidden link (accessible=false)
                        Group {
                            Text("TC-19: Hidden Link — accessible=false (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link hidden from VoiceOver — check should be skipped")
                                .font(.caption)
                            Link("Click here", destination: URL(string: "https://example.com")!)
                                .accessibilityHidden(true)
                                .accessibilityIdentifier("tc19_hidden_link")
                            Text("SKIP: Element has accessible=false — not exposed to assistive technology")
                                .font(.caption)
                        }

                        Divider()

                        // TC-20: Link with empty label
                        Group {
                            Text("TC-20: Link with Empty Label (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with empty accessibility label — nothing to check against blocklist")
                                .font(.caption)
                            Link("", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc20_empty_label_link")
                            Text("SKIP: Empty label — no text to validate")
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
        LinkTextPurposeView()
    }
}
