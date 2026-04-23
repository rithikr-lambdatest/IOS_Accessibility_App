import SwiftUI

struct SpecialCharacterLabelView: View {
    @State private var emojiToggle = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // AT-880: Special Characters in Accessibility Labels
                VStack(alignment: .leading, spacing: 20) {
                    Text("AT-880: Special Characters in Labels")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Detects emoji and special characters in interactive element accessibility labels. Only interactive elements (buttons, links, controls) are checked — static text is excluded.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Button with emoji-only label
                        Group {
                            Text("TC-01: Emoji-Only Label on Button")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with only emoji '⭐' as accessibility label — no descriptive text")
                                .font(.caption)
                            Button(action: {}) {
                                Text("⭐")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("⭐")
                            .accessibilityIdentifier("tc01_emoji_only_button")
                            Text("⚠️ VIOLATION: Label is only emoji, no descriptive text for screen readers")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Button with special characters only
                        Group {
                            Text("TC-02: Special Characters Only Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with only special characters '★●◆' as accessibility label")
                                .font(.caption)
                            Button(action: {}) {
                                Text("★●◆")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("★●◆")
                            .accessibilityIdentifier("tc02_special_chars_only_button")
                            Text("⚠️ VIOLATION: Label contains only special characters")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Button with arrows only
                        Group {
                            Text("TC-03: Arrow Characters Only Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with only arrow characters '→←↑↓' as accessibility label")
                                .font(.caption)
                            Button(action: {}) {
                                Text("→")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("→←↑↓")
                            .accessibilityIdentifier("tc03_arrows_only_button")
                            Text("⚠️ VIOLATION: Label contains only arrow special characters")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Switch with emoji-only label
                        Group {
                            Text("TC-04: Emoji-Only Label on Switch")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle switch with only emoji '🔔' as accessibility label")
                                .font(.caption)
                            Toggle(isOn: $emojiToggle) {
                                Text("🔔")
                            }
                            .accessibilityLabel("🔔")
                            .accessibilityIdentifier("tc04_emoji_only_switch")
                            Text("⚠️ VIOLATION: Interactive switch label is only emoji")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: Button with math symbols only
                        Group {
                            Text("TC-05: Math Symbols Only Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with only math symbols '±×÷' as accessibility label")
                                .font(.caption)
                            Button(action: {}) {
                                Text("±×÷")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("±×÷")
                            .accessibilityIdentifier("tc05_math_symbols_button")
                            Text("⚠️ VIOLATION: Label contains only math symbols")
                                .font(.caption)
                        }

                        Divider()

                        // TC-06: Link with emoji-only label
                        Group {
                            Text("TC-06: Emoji-Only Label on Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link with only emoji '🔗' as accessibility label — no descriptive text")
                                .font(.caption)
                            Link("🔗", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("🔗")
                                .accessibilityIdentifier("tc06_emoji_only_link")
                            Text("⚠️ VIOLATION: Interactive link label is only emoji")
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

                        // TC-07: Static text with emoji (SKIP)
                        Group {
                            Text("TC-07: Emoji on Static Text (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Static text elements are excluded from this check")
                                .font(.caption)
                            Text("⭐")
                                .font(.title)
                                .accessibilityLabel("⭐")
                                .accessibilityIdentifier("tc06_emoji_static_text")
                            Text("✅ SKIP: Static text — not an interactive element")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Button with emoji + descriptive text
                        Group {
                            Text("TC-08: Emoji with Descriptive Text (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button label has emoji but also meaningful descriptive text")
                                .font(.caption)
                            Button(action: {}) {
                                Text("⭐ Favorites")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("⭐ Favorites")
                            .accessibilityIdentifier("tc07_emoji_with_text_button")
                            Text("✅ PASS: Label has descriptive text alongside emoji")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: Button with trailing emoji
                        Group {
                            Text("TC-09: Descriptive Text with Trailing Emoji (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button label has descriptive text with emoji appended")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Settings 🔧")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Settings 🔧")
                            .accessibilityIdentifier("tc08_text_with_emoji_button")
                            Text("✅ PASS: Label has descriptive text with trailing emoji")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Link with emoji + descriptive text
                        Group {
                            Text("TC-10: Link with Emoji and Text (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Link label has emoji but also meaningful descriptive text")
                                .font(.caption)
                            Link("📖 Read More", destination: URL(string: "https://example.com")!)
                                .accessibilityLabel("📖 Read More")
                                .accessibilityIdentifier("tc10_emoji_with_text_link")
                            Text("✅ PASS: Link label has descriptive text alongside emoji")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: Button with clean text label
                        Group {
                            Text("TC-11: Clean Text Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with a clean descriptive label, no special characters")
                                .font(.caption)
                            Button(action: {}) {
                                Text("Add to Favorites")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("Add to Favorites")
                            .accessibilityIdentifier("tc09_clean_text_button")
                            Text("✅ PASS: Label is clean descriptive text")
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
        SpecialCharacterLabelView()
    }
}
