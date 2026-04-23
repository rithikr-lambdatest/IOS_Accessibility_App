import SwiftUI

struct ViewStateLabelView: View {
    @State private var menuExpanded = true
    @State private var tc01DarkModeOn = true
    @State private var tc02WifiOff = false
    @State private var tc03NotificationsDimmed = false
    @State private var tc04ThemeSelected = true
    @State private var tc05DetailsExpanded = true
    @State private var tc13DarkMode = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // AT-881: View State in Accessibility Labels
                VStack(alignment: .leading, spacing: 20) {
                    Text("AT-881: View State in Labels")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Detects redundant state keywords in accessibility labels that VoiceOver already announces automatically, causing double announcements like \"WiFi ON, on\".")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Switch with "ON" in label
                        Group {
                            Text("TC-01: Switch Label Contains \"ON\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle with \"Dark Mode ON\" — VoiceOver already says \"on\" for switch state")
                                .font(.caption)
                            Toggle(isOn: $tc01DarkModeOn) {
                                Text("Dark Mode ON")
                            }
                            .accessibilityLabel("Dark Mode ON")
                            .accessibilityIdentifier("tc01_state_on_switch")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Dark Mode ON, on\" — redundant state")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Switch with "OFF" in label
                        Group {
                            Text("TC-02: Switch Label Contains \"OFF\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle with \"WiFi is OFF\" — VoiceOver already says \"off\" for switch state")
                                .font(.caption)
                            Toggle(isOn: $tc02WifiOff) {
                                Text("WiFi is OFF")
                            }
                            .accessibilityLabel("WiFi is OFF")
                            .accessibilityIdentifier("tc02_state_off_switch")
                            Text("⚠️ VIOLATION: VoiceOver announces \"WiFi is OFF, off\" — redundant state")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Switch with "dimmed" in label
                        Group {
                            Text("TC-03: Switch Label Contains \"dimmed\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Disabled switch with \"Notifications dimmed\" — VoiceOver already says \"dimmed\" for disabled state")
                                .font(.caption)
                            Toggle(isOn: $tc03NotificationsDimmed) {
                                Text("Notifications dimmed")
                            }
                            .disabled(true)
                            .accessibilityLabel("Notifications dimmed")
                            .accessibilityIdentifier("tc03_state_dimmed_switch")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Notifications dimmed, dimmed\" — redundant state")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Switch with "selected" in label
                        Group {
                            Text("TC-04: Switch Label Contains \"selected\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Switch with \"Theme selected\" — VoiceOver already says \"selected\"")
                                .font(.caption)
                            Toggle(isOn: $tc04ThemeSelected) {
                                Text("Theme selected")
                            }
                            .accessibilityAddTraits(.isSelected)
                            .accessibilityLabel("Theme selected")
                            .accessibilityIdentifier("tc04_state_selected_switch")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Theme selected, selected\" — redundant state")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: DisclosureGroup with "expanded" in label
                        Group {
                            Text("TC-05: DisclosureGroup Label Contains \"expanded\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("DisclosureGroup with \"Details Expanded\" — VoiceOver already announces expanded state")
                                .font(.caption)
                            DisclosureGroup("Details Expanded", isExpanded: $tc05DetailsExpanded) {
                                Text("Content here")
                            }
                            .accessibilityLabel("Details Expanded")
                            .accessibilityIdentifier("tc05_state_expanded_disclosure")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Details Expanded, expanded\" — redundant state")
                                .font(.caption)
                        }

                        Divider()

                        // TC-06: Link with "selected" in label
                        Group {
                            Text("TC-06: Link Label Contains \"selected\"")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with \"Home selected\" — VoiceOver already announces \"selected\"")
                                .font(.caption)
                            Link("Home selected", destination: URL(string: "https://example.com")!)
                                .accessibilityAddTraits(.isSelected)
                                .accessibilityLabel("Home selected")
                                .accessibilityIdentifier("tc06_state_selected_link")
                            Text("⚠️ VIOLATION: VoiceOver announces \"Home selected, selected\" — redundant state")
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

                        // TC-07: "disabled" not flagged (VO says "dimmed")
                        Group {
                            Text("TC-07: Label Contains \"disabled\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver says \"dimmed\" not \"disabled\" — so \"disabled\" in label is not redundant")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Feature Disabled")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(true)
                            .accessibilityLabel("Feature Disabled")
                            .accessibilityIdentifier("tc06_disabled_not_flagged")
                            Text("✅ PASS: VoiceOver says \"dimmed\" not \"disabled\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Compound word "Onboarding" (PASS)
                        Group {
                            Text("TC-08: Compound Word \"Onboarding\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Word boundary matching prevents false positive — \"Onboarding\" is not \"on\"")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Onboarding")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Onboarding")
                            .accessibilityIdentifier("tc07_compound_word_onboarding")
                            Text("✅ PASS: \"Onboarding\" is a compound word, not the state keyword \"on\"")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: "enabled" not flagged (VO doesn't announce)
                        Group {
                            Text("TC-09: Label Contains \"enabled\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver doesn't announce \"enabled\" — so it's not redundant")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Feature Enabled")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Feature Enabled")
                            .accessibilityIdentifier("tc08_enabled_not_flagged")
                            Text("✅ PASS: VoiceOver doesn't announce \"enabled\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: "collapsed" not flagged (VO doesn't announce)
                        Group {
                            Text("TC-10: Label Contains \"collapsed\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver doesn't announce \"collapsed\" — so it's not redundant")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Menu collapsed")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Menu collapsed")
                            .accessibilityIdentifier("tc09_collapsed_not_flagged")
                            Text("✅ PASS: VoiceOver doesn't announce \"collapsed\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: "unselected" not flagged (VO doesn't announce)
                        Group {
                            Text("TC-11: Label Contains \"unselected\" (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("VoiceOver doesn't announce \"unselected\" — so it's not redundant")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Tab unselected")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Tab unselected")
                            .accessibilityIdentifier("tc11_unselected_not_flagged")
                            Text("✅ PASS: VoiceOver doesn't announce \"unselected\" — no redundancy")
                                .font(.caption)
                        }

                        Divider()

                        // TC-12: Link with clean label (PASS)
                        Group {
                            Text("TC-12: Link with Clean Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link label with no state keywords")
                                .font(.caption)
                            Link("Privacy Policy", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("Privacy Policy")
                                .accessibilityIdentifier("tc12_clean_label_link")
                            Text("✅ PASS: Link label contains no state keywords")
                                .font(.caption)
                        }

                        Divider()

                        // TC-13: Clean label with no state keywords
                        Group {
                            Text("TC-13: Clean Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Label with no state keywords at all")
                                .font(.caption)
                            Toggle(isOn: $tc13DarkMode) {
                                Text("Dark Mode")
                            }
                            .accessibilityLabel("Dark Mode")
                            .accessibilityIdentifier("tc13_clean_label_switch")
                            Text("✅ PASS: Label contains no state keywords")
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
        ViewStateLabelView()
    }
}
