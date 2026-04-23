import SwiftUI

struct ColorContrastView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Color Contrast")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures text and non-text UI elements maintain sufficient color contrast against their backgrounds. Text requires 4.5:1 for normal and 3:1 for large text. Non-text elements (icons, buttons, images) require 3:1.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Text Contrast Violations
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Text Contrast — Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Light gray text on white background
                        Group {
                            Text("TC-01: Light Gray Text on White")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Gray text (#AAAAAA) on white — ratio ~2.3:1, fails 4.5:1")
                                .font(.caption)
                            Text("This text is hard to read")
                                .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                                .accessibilityIdentifier("tc01_text_low_contrast")
                        }

                        Divider()

                        // TC-02: Light orange text on white background
                        Group {
                            Text("TC-02: Light Orange Text on White")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Orange text (#FFA500) on white — ratio ~2.1:1, fails 4.5:1")
                                .font(.caption)
                            Text("Warning: check your input")
                                .foregroundColor(Color(red: 1.0, green: 0.65, blue: 0.0))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                                .accessibilityIdentifier("tc02_text_orange_low_contrast")
                        }

                        Divider()

                        // TC-03: Yellow text on white background
                        Group {
                            Text("TC-03: Yellow Text on White")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Yellow text (#CCCC00) on white — ratio ~1.6:1, fails 4.5:1")
                                .font(.caption)
                            Text("Important notice here")
                                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.0))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                                .accessibilityIdentifier("tc03_text_yellow_low_contrast")
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Text Contrast Positive Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Text Contrast — Positive Test Cases (VALID)")
                            .font(.headline)
                            .foregroundColor(Color(red: 0, green: 0.5, blue: 0))

                        // TC-04: Dark text on white
                        Group {
                            Text("TC-04: Dark Text on White (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Dark gray text (#333333) on white — ratio ~12.6:1, passes 4.5:1")
                                .font(.caption)
                            Text("This text is easy to read")
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                                .accessibilityIdentifier("tc04_text_high_contrast")
                        }

                        Divider()

                        // TC-05: White text on dark background
                        Group {
                            Text("TC-05: White Text on Dark Background (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("White text on dark blue — ratio ~8.6:1, passes 4.5:1")
                                .font(.caption)
                            Text("White on dark background")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0.1, green: 0.1, blue: 0.4))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc05_text_white_on_dark")
                        }

                        Divider()

                        // TC-06: Large text with 3:1 contrast
                        Group {
                            Text("TC-06: Large Text with 3:1 Contrast (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Large text (18pt+) only needs 3:1 ratio")
                                .font(.caption)
                            Text("Large heading text")
                                .font(.title)
                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                                .accessibilityIdentifier("tc06_large_text_contrast")
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
        ColorContrastView()
    }
}
