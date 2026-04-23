import SwiftUI

struct TouchTargetSpacingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Touch Target Spacing")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Interactive elements must have adequate spacing between them. Edge-to-edge gap <8pt causes accidental activation for motor-impaired users. Elements where both are >=44x44pt are exempt. WCAG 2.5.8 (Level AA).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Small buttons with 0pt gap
                        Group {
                            Text("TC-01: Small Buttons — 0pt Gap")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two small buttons (30x30) with zero spacing — touching edges")
                                .font(.caption)
                            HStack(spacing: 0) {
                                Button(action: {}) {
                                    Image(systemName: "plus")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Add")
                                .accessibilityIdentifier("tc01_zero_gap_btn1")

                                Button(action: {}) {
                                    Image(systemName: "minus")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Remove")
                                .accessibilityIdentifier("tc01_zero_gap_btn2")
                            }
                            Text("VIOLATION: 0pt edge gap between small buttons — accidental activation risk")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Small buttons with 2pt gap
                        Group {
                            Text("TC-02: Small Buttons — 2pt Gap")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two small buttons with 2pt spacing — well below 8pt threshold")
                                .font(.caption)
                            HStack(spacing: 2) {
                                Button(action: {}) {
                                    Image(systemName: "heart")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Favorite")
                                .accessibilityIdentifier("tc02_2pt_gap_btn1")

                                Button(action: {}) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Share")
                                .accessibilityIdentifier("tc02_2pt_gap_btn2")
                            }
                            Text("VIOLATION: 2pt edge gap — below 8pt minimum spacing threshold")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Small buttons with 4pt gap
                        Group {
                            Text("TC-03: Small Buttons — 4pt Gap")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two small buttons with 4pt spacing — still below 8pt threshold")
                                .font(.caption)
                            HStack(spacing: 4) {
                                Button(action: {}) {
                                    Image(systemName: "hand.thumbsup")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Like")
                                .accessibilityIdentifier("tc03_4pt_gap_btn1")

                                Button(action: {}) {
                                    Image(systemName: "hand.thumbsdown")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Dislike")
                                .accessibilityIdentifier("tc03_4pt_gap_btn2")
                            }
                            Text("VIOLATION: 4pt edge gap — below 8pt minimum spacing threshold")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Row of small icon buttons with 2pt gap
                        Group {
                            Text("TC-04: Toolbar Icons — 2pt Gap")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Row of small toolbar icons with minimal spacing")
                                .font(.caption)
                            HStack(spacing: 2) {
                                ForEach(["bold", "italic", "underline"], id: \.self) { icon in
                                    Button(action: {}) {
                                        Image(systemName: icon)
                                            .font(.caption)
                                    }
                                    .frame(width: 28, height: 28)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                                    .accessibilityLabel(icon.capitalized)
                                    .accessibilityIdentifier("tc04_toolbar_\(icon)")
                                }
                            }
                            Text("VIOLATION: Toolbar icons with 2pt gap — too close for motor-impaired users")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: Vertically close small buttons
                        Group {
                            Text("TC-05: Vertical Small Buttons — 4pt Gap")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Vertically stacked small buttons with insufficient spacing")
                                .font(.caption)
                            VStack(spacing: 4) {
                                Button(action: {}) {
                                    Text("Up")
                                        .font(.caption)
                                }
                                .frame(width: 60, height: 28)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityIdentifier("tc05_vert_up")

                                Button(action: {}) {
                                    Text("Down")
                                        .font(.caption)
                                }
                                .frame(width: 60, height: 28)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityIdentifier("tc05_vert_down")
                            }
                            Text("VIOLATION: 4pt vertical gap between small buttons — below 8pt threshold")
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

                        // TC-06: Small buttons with 10pt gap
                        Group {
                            Text("TC-06: Small Buttons — 10pt Gap (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Small buttons with 10pt spacing — above 8pt threshold")
                                .font(.caption)
                            HStack(spacing: 10) {
                                Button(action: {}) {
                                    Image(systemName: "plus")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Add")
                                .accessibilityIdentifier("tc06_10pt_gap_btn1")

                                Button(action: {}) {
                                    Image(systemName: "minus")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityLabel("Remove")
                                .accessibilityIdentifier("tc06_10pt_gap_btn2")
                            }
                            Text("PASS: 10pt edge gap exceeds 8pt minimum threshold")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Large buttons (44x44) with 0pt gap — exempt
                        Group {
                            Text("TC-07: Large Buttons (44x44) — 0pt Gap, Size Exempt (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Both buttons are >=44x44pt — exempt from spacing check per Apple HIG")
                                .font(.caption)
                            HStack(spacing: 0) {
                                Button(action: {}) {
                                    Text("Save")
                                        .font(.body)
                                }
                                .frame(width: 80, height: 44)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc07_large_save")

                                Button(action: {}) {
                                    Text("Cancel")
                                        .font(.body)
                                }
                                .frame(width: 80, height: 44)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc07_large_cancel")
                            }
                            Text("PASS: Both elements >=44x44pt — size exemption applies (intentional design choice)")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Buttons with generous spacing
                        Group {
                            Text("TC-08: Buttons with 16pt Spacing (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Standard button layout with generous spacing")
                                .font(.caption)
                            HStack(spacing: 16) {
                                Button(action: {}) {
                                    Text("Accept")
                                        .frame(width: 100, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc08_spaced_accept")

                                Button(action: {}) {
                                    Text("Decline")
                                        .frame(width: 100, height: 44)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc08_spaced_decline")
                            }
                            Text("PASS: 16pt gap — well above 8pt minimum threshold")
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

                        Text("These elements should be skipped by the Touch Target Spacing check — no violation should be reported.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-09: Non-interactive elements close together
                        Group {
                            Text("TC-09: Non-Interactive Elements Close Together (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Static text labels close together — spacing check only applies to interactive elements")
                                .font(.caption)
                            HStack(spacing: 2) {
                                Text("Label A")
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .accessibilityIdentifier("tc09_static_a")

                                Text("Label B")
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .accessibilityIdentifier("tc09_static_b")
                            }
                            Text("SKIP: Non-interactive elements — spacing check only applies to buttons, links, text fields, switches")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Parent-child close elements
                        Group {
                            Text("TC-10: Parent-Child Elements (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button inside a tappable container — parent-child pairs are skipped")
                                .font(.caption)
                            VStack(spacing: 0) {
                                Button(action: {}) {
                                    Text("Inner Button")
                                        .frame(width: 120, height: 34)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc10_inner_button")
                            }
                            .frame(width: 160, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .accessibilityElement(children: .contain)
                            .accessibilityIdentifier("tc10_outer_container")
                            Text("SKIP: Parent-child pair — spacing between container and its child is not a violation")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: Hidden close elements
                        Group {
                            Text("TC-11: Hidden Element Close to Visible (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("One button is hidden from accessibility — invisible elements are skipped")
                                .font(.caption)
                            HStack(spacing: 2) {
                                Button(action: {}) {
                                    Text("Visible")
                                        .font(.caption)
                                }
                                .frame(width: 60, height: 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityIdentifier("tc11_visible_btn")

                                Button(action: {}) {
                                    Text("Hidden")
                                        .font(.caption)
                                }
                                .frame(width: 60, height: 30)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .accessibilityHidden(true)
                                .accessibilityIdentifier("tc11_hidden_btn")
                            }
                            Text("SKIP: One element has accessible=false — not visible to assistive technology")
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
        TouchTargetSpacingView()
    }
}
