import SwiftUI

struct MissingImageLabelView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Missing Image Element Label")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures all image elements have descriptive accessibility labels so screen readers can convey their content and purpose.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Cat image with empty label
                        Group {
                            Text("TC-01: Image with Empty Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Cat image with empty accessibility label — screen reader cannot describe content")
                                .font(.caption)
                            Image("cat")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipped()
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc01_image_empty_label")
                        }

                        Divider()

                        // TC-02: Heart icon button with no label
                        Group {
                            Text("TC-02: Tappable Image with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Heart icon with tap gesture acting as interactive element but no label")
                                .font(.caption)
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.red)
                                .onTapGesture {}
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc02_heart_button_no_label")
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

                        // TC-03: Cat image with label (PASS)
                        Group {
                            Text("TC-03: Image with Random Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Cat image with a label — rule only checks if label exists, not accuracy")
                                .font(.caption)
                            Image("cat")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipped()
                                .accessibilityLabel("A cute brown dog playing with a ball")
                                .accessibilityIdentifier("tc03_image_with_label")
                        }

                        Divider()

                        // TC-04: Cat image with accurate label (PASS)
                        Group {
                            Text("TC-04: Image with Accurate Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Cat image with accurate descriptive label")
                                .font(.caption)
                            Image("cat")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipped()
                                .accessibilityLabel("Brown sitting cat")
                                .accessibilityIdentifier("tc04_image_accurate_label")
                        }

                        Divider()

                        // TC-05: Heart icon button with label (PASS)
                        Group {
                            Text("TC-05: Tappable Image with Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Heart icon with tap gesture and a descriptive accessibility label")
                                .font(.caption)
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.red)
                                .onTapGesture {}
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Add to Favorites")
                                .accessibilityIdentifier("tc05_heart_button_with_label")
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
        MissingImageLabelView()
    }
}
