import SwiftUI

struct OverlappingElementsView: View {
    @State private var enableToggle = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Overlapping Elements")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Interactive elements must not overlap. Overlapping buttons, links, or inputs cause mis-taps for motor-impaired users and confuse assistive technologies. Violation when overlap >10% of smaller element's area. WCAG 2.5.5, 1.3.2.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Two buttons significantly overlapping
                        Group {
                            Text("TC-01: Two Buttons Overlapping (~50%)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two buttons overlap significantly — impossible to tap the intended one reliably")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Button(action: {}) {
                                    Text("Save")
                                        .frame(width: 100, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc01_overlap_button_1")

                                Button(action: {}) {
                                    Text("Cancel")
                                        .frame(width: 100, height: 44)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 50, y: 10)
                                .accessibilityIdentifier("tc01_overlap_button_2")
                            }
                            .frame(height: 60)
                            Text("VIOLATION: Buttons overlap >10% — motor-impaired users cannot reliably target either button")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Button overlapping a link
                        Group {
                            Text("TC-02: Button Overlapping a Link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("A button partially covers a link — overlapping interactive elements")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Link("Visit Website", destination: URL(string: "https://example.com")!)
                                    .frame(width: 120, height: 44)
                                    .background(Color.green.opacity(0.3))
                                    .cornerRadius(8)
                                    .accessibilityIdentifier("tc02_overlap_link")

                                Button(action: {}) {
                                    Text("Share")
                                        .frame(width: 80, height: 44)
                                        .background(Color.purple)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 70, y: 0)
                                .accessibilityIdentifier("tc02_overlap_button")
                            }
                            .frame(height: 50)
                            Text("VIOLATION: Button overlaps link >10% — confuses assistive technology navigation")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Three buttons stacked with overlaps
                        Group {
                            Text("TC-03: Three Buttons Stacked with Overlaps")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Multiple buttons overlap in a stacked layout — each pair exceeds 10% threshold")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Button(action: {}) {
                                    Text("First")
                                        .frame(width: 100, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc03_stacked_button_1")

                                Button(action: {}) {
                                    Text("Second")
                                        .frame(width: 100, height: 44)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 20, y: 20)
                                .accessibilityIdentifier("tc03_stacked_button_2")

                                Button(action: {}) {
                                    Text("Third")
                                        .frame(width: 100, height: 44)
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 40, y: 40)
                                .accessibilityIdentifier("tc03_stacked_button_3")
                            }
                            .frame(height: 90)
                            Text("VIOLATION: Multiple overlapping interactive elements — cascading overlap violations")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Toggle overlapping a button
                        Group {
                            Text("TC-04: Toggle Overlapping a Button")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("A toggle switch overlaps with a nearby button")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Toggle(isOn: $enableToggle) {
                                    Text("Enable")
                                }
                                .frame(width: 150)
                                .accessibilityIdentifier("tc04_overlap_toggle")

                                Button(action: {}) {
                                    Text("Reset")
                                        .frame(width: 80, height: 34)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 100, y: 0)
                                .accessibilityIdentifier("tc04_overlap_reset_button")
                            }
                            .frame(height: 44)
                            Text("VIOLATION: Toggle and button overlap >10% — users may activate wrong control")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: TextField overlapping a button
                        Group {
                            Text("TC-05: TextField Overlapping a Button")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("A text field partially covers a submit button")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                TextField("Enter email", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 200)
                                    .accessibilityIdentifier("tc05_overlap_textfield")

                                Button(action: {}) {
                                    Text("Submit")
                                        .frame(width: 80, height: 34)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 160, y: 0)
                                .accessibilityIdentifier("tc05_overlap_submit")
                            }
                            .frame(height: 44)
                            Text("VIOLATION: TextField and button overlap — input and action elements interfere")
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

                        // TC-06: Buttons side by side, no overlap
                        Group {
                            Text("TC-06: Buttons Side by Side — No Overlap (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two buttons placed with proper spacing — no frame overlap")
                                .font(.caption)
                            HStack(spacing: 16) {
                                Button(action: {}) {
                                    Text("Save")
                                        .frame(width: 100, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc06_no_overlap_save")

                                Button(action: {}) {
                                    Text("Cancel")
                                        .frame(width: 100, height: 44)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc06_no_overlap_cancel")
                            }
                            Text("PASS: Buttons have clear spacing — no frame overlap")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Vertically stacked buttons, no overlap
                        Group {
                            Text("TC-07: Vertically Stacked — No Overlap (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Buttons stacked vertically with proper spacing")
                                .font(.caption)
                            VStack(spacing: 12) {
                                Button(action: {}) {
                                    Text("Option A")
                                        .frame(width: 150, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc07_stacked_a")

                                Button(action: {}) {
                                    Text("Option B")
                                        .frame(width: 150, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc07_stacked_b")
                            }
                            Text("PASS: Vertically stacked buttons with adequate spacing")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Elements touching but not overlapping (edge-to-edge)
                        Group {
                            Text("TC-08: Edge-to-Edge — Under 10% Threshold (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Buttons touching at edges but overlap is under 10% threshold")
                                .font(.caption)
                            HStack(spacing: 0) {
                                Button(action: {}) {
                                    Text("Left")
                                        .frame(width: 80, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                }
                                .accessibilityIdentifier("tc08_edge_left")

                                Button(action: {}) {
                                    Text("Right")
                                        .frame(width: 80, height: 44)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                }
                                .accessibilityIdentifier("tc08_edge_right")
                            }
                            Text("PASS: Buttons share an edge but frames don't overlap (0% overlap)")
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

                        Text("These elements should be skipped by the Overlapping Elements check — no violation should be reported.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-09: Parent-child overlap (container contains child)
                        Group {
                            Text("TC-09: Parent-Child Pair — Container Contains Button (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Button inside a container — parent naturally contains child, not a real overlap")
                                .font(.caption)
                            VStack {
                                Button(action: {}) {
                                    Text("Contained Button")
                                        .frame(width: 120, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc09_child_button")
                            }
                            .frame(width: 200, height: 80)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .accessibilityElement(children: .contain)
                            .accessibilityIdentifier("tc09_parent_container")
                            Text("SKIP: Parent-child pair — container naturally contains its child element")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Non-interactive elements overlapping
                        Group {
                            Text("TC-10: Non-Interactive Elements Overlapping (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two static text elements overlap — check only applies to interactive elements")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Text("First Label")
                                    .padding()
                                    .background(Color.yellow.opacity(0.3))
                                    .accessibilityIdentifier("tc10_static_text_1")

                                Text("Second Label")
                                    .padding()
                                    .background(Color.cyan.opacity(0.3))
                                    .offset(x: 30, y: 5)
                                    .accessibilityIdentifier("tc10_static_text_2")
                            }
                            .frame(height: 50)
                            Text("SKIP: Non-interactive elements — overlap check only applies to buttons, links, text fields, switches")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: Hidden overlapping elements
                        Group {
                            Text("TC-11: Hidden Overlapping Elements (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Two overlapping buttons but one is hidden from accessibility")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Button(action: {}) {
                                    Text("Visible")
                                        .frame(width: 100, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc11_visible_button")

                                Button(action: {}) {
                                    Text("Hidden")
                                        .frame(width: 100, height: 44)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .offset(x: 40, y: 0)
                                .accessibilityHidden(true)
                                .accessibilityIdentifier("tc11_hidden_button")
                            }
                            .frame(height: 50)
                            Text("SKIP: One element has accessible=false — invisible to assistive technology")
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
        OverlappingElementsView()
    }
}
