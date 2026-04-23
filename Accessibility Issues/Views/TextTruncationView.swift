import SwiftUI

struct TextTruncationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Text Truncation")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures text resizes correctly when users increase their preferred font size. Text must remain visible and functional without truncation or layout issues up to 200% magnification.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Fixed font size text
                        Group {
                            Text("TC-01: Fixed Font Size Text")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text uses a fixed font size that does not scale with Dynamic Type")
                                .font(.caption)
                            Text("This text will not scale")
                                .font(.system(size: 16))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.red.opacity(0.2))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc01_fixed_font_size")
                        }

                        Divider()

                        // TC-02: Fixed frame truncating text
                        Group {
                            Text("TC-02: Fixed Frame Truncating Text")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text in a fixed-height container that truncates when font size increases")
                                .font(.caption)
                            Text("This text will be truncated when the user increases font size in system settings because the container has a fixed height")
                                .font(.system(size: 14))
                                .frame(height: 20, alignment: .top)
                                .clipped()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.red.opacity(0.2))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc02_fixed_frame_truncation")
                        }

                        Divider()

                        // TC-03: Fixed font with lineLimit
                        Group {
                            Text("TC-03: Text with lineLimit Cutting Off Content")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text limited to 1 line with fixed font — content cut off at larger sizes")
                                .font(.caption)
                            Text("This is a long piece of text that should wrap to multiple lines but is restricted to a single line causing content loss")
                                .font(.system(size: 14))
                                .lineLimit(1)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.red.opacity(0.2))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc03_line_limit_fixed_font")
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

                        // TC-04: Dynamic Type text
                        Group {
                            Text("TC-04: Dynamic Type Text (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text uses Dynamic Type and scales with user font size preferences")
                                .font(.caption)
                            Text("This text scales with Dynamic Type")
                                .font(.body)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0, green: 0.5, blue: 0).opacity(0.2))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc04_dynamic_type_text")
                        }

                        Divider()

                        // TC-05: Scalable custom font
                        Group {
                            Text("TC-05: Scalable Custom Font (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Custom font size scaled using @ScaledMetric for Dynamic Type support")
                                .font(.caption)
                            ScalableTextView()
                                .accessibilityIdentifier("tc05_scaled_metric_text")
                        }

                        Divider()

                        // TC-06: Flexible container with Dynamic Type
                        Group {
                            Text("TC-06: Flexible Container with Dynamic Type (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text in a flexible container that adapts when font size increases")
                                .font(.caption)
                            Text("This text is in a flexible container that grows with the content and supports Dynamic Type scaling without truncation")
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0, green: 0.5, blue: 0).opacity(0.2))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc06_flexible_container")
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

struct ScalableTextView: View {
    @ScaledMetric(relativeTo: .body) private var fontSize: CGFloat = 16

    var body: some View {
        Text("This text uses @ScaledMetric")
            .font(.system(size: fontSize))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0, green: 0.5, blue: 0).opacity(0.2))
            .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        TextTruncationView()
    }
}
