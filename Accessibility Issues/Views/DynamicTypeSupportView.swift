import SwiftUI

struct DynamicTypeSupportView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Dynamic Type Support")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures text scales with the user's preferred content size. Text set at a fixed point size ignores Dynamic Type and stays the same size no matter what the user selects in system settings.")
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
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
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
        DynamicTypeSupportView()
    }
}
