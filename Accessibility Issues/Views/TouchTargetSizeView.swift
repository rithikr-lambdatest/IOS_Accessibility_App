import SwiftUI

struct TouchTargetSizeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Touch Target Size and Spacing")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures interactive elements have adequate size (minimum 44x44 points on iOS) and spacing to accommodate users with motor or visual impairments.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Small button
                        Group {
                            Text("TC-01: Small Button (20x20)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button with 20x20 touch target — below 44x44 minimum")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "plus")
                                    .font(.caption2)
                            }
                            .frame(width: 20, height: 20)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                            .accessibilityLabel("Add")
                            .accessibilityIdentifier("tc01_small_button")
                        }

                        Divider()

                        // TC-02: Small icon button
                        Group {
                            Text("TC-02: Small Icon Button (24x24)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon button with 24x24 touch target — below 44x44 minimum")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .font(.caption)
                            }
                            .frame(width: 24, height: 24)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                            .accessibilityLabel("Close")
                            .accessibilityIdentifier("tc02_small_icon_button")
                        }

                        Divider()

                        // TC-03: Buttons too close together
                        Group {
                            Text("TC-03: Buttons with No Spacing")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Small buttons placed with no spacing — easy to tap wrong target")
                                .font(.caption)
                            HStack(spacing: 0) {
                                Button(action: {}) {
                                    Image(systemName: "hand.thumbsup")
                                        .font(.caption2)
                                }
                                .frame(width: 24, height: 24)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .accessibilityLabel("Like")
                                .accessibilityIdentifier("tc03_close_button_1")

                                Button(action: {}) {
                                    Image(systemName: "hand.thumbsdown")
                                        .font(.caption2)
                                }
                                .frame(width: 24, height: 24)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .accessibilityLabel("Dislike")
                                .accessibilityIdentifier("tc03_close_button_2")
                            }
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

                        // TC-04: Properly sized button
                        Group {
                            Text("TC-04: Properly Sized Button (44x44) (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button meets the 44x44 minimum touch target size")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "plus")
                                    .font(.body)
                            }
                            .frame(width: 44, height: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .accessibilityLabel("Add")
                            .accessibilityIdentifier("tc04_proper_button")
                        }

                        Divider()

                        // TC-05: Properly sized icon button
                        Group {
                            Text("TC-05: Properly Sized Icon Button (44x44) (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Icon button meets the 44x44 minimum touch target size")
                                .font(.caption)
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .font(.body)
                            }
                            .frame(width: 44, height: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .accessibilityLabel("Close")
                            .accessibilityIdentifier("tc05_proper_icon_button")
                        }

                        Divider()

                        // TC-06: Buttons with adequate spacing
                        Group {
                            Text("TC-06: Buttons with Adequate Spacing (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Properly sized buttons with adequate spacing between them")
                                .font(.caption)
                            HStack(spacing: 16) {
                                Button(action: {}) {
                                    Image(systemName: "hand.thumbsup")
                                        .font(.body)
                                }
                                .frame(width: 44, height: 44)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .accessibilityLabel("Like")
                                .accessibilityIdentifier("tc06_spaced_button_1")

                                Button(action: {}) {
                                    Image(systemName: "hand.thumbsdown")
                                        .font(.body)
                                }
                                .frame(width: 44, height: 44)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .accessibilityLabel("Dislike")
                                .accessibilityIdentifier("tc06_spaced_button_2")
                            }
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
        TouchTargetSizeView()
    }
}
