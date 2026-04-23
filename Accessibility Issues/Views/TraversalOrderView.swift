import SwiftUI

struct TraversalOrderView: View {
    @State private var enableFeature = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Traversal Order")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("VoiceOver reads elements in DOM order. When DOM order doesn't match the visual layout (top-to-bottom, left-to-right), screen reader users hear content in a confusing sequence. Only interactive elements are checked — adjacent pairs within the same parent are compared. WCAG 2.4.3 (Level A).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Form fields in wrong visual order (interactive elements)
                        Group {
                            Text("TC-01: Form Fields — Wrong Tab Order")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("TextField elements in DOM order Phone, Name, Email but visually displayed top-to-bottom — adjacent pair inversion detected on interactive elements")
                                .font(.caption)
                            VStack(spacing: 8) {
                                TextField("Phone", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityIdentifier("tc01_phone_field")
                                    .accessibilitySortPriority(3)

                                TextField("Name", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityIdentifier("tc01_name_field")
                                    .accessibilitySortPriority(1)

                                TextField("Email", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityIdentifier("tc01_email_field")
                                    .accessibilitySortPriority(2)
                            }
                            .padding(.horizontal)
                            Text("VIOLATION: VoiceOver reads Phone, Name, Email — doesn't match visual top-to-bottom order")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Buttons in VStack — DOM reversed via accessibilitySortPriority
                        Group {
                            Text("TC-02: Buttons — Reversed DOM Order")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Buttons visually top-to-bottom: Save, Delete. But accessibilitySortPriority makes DOM order Delete(2), Save(1) — adjacent pair inversion")
                                .font(.caption)
                            VStack(spacing: 10) {
                                Button(action: {}) {
                                    Text("Save")
                                        .frame(width: 200, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilitySortPriority(1)
                                .accessibilityIdentifier("tc02_save_button")

                                Button(action: {}) {
                                    Text("Delete")
                                        .frame(width: 200, height: 44)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilitySortPriority(2)
                                .accessibilityIdentifier("tc02_delete_button")
                            }
                            Text("VIOLATION: DOM reads Delete then Save (sort priority), but visually Save is above Delete")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Toggle and button — DOM swapped via accessibilitySortPriority
                        Group {
                            Text("TC-03: Toggle + Button — Swapped DOM Order")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Toggle visually above Button, but accessibilitySortPriority makes DOM read Button first — adjacent pair inversion")
                                .font(.caption)
                            VStack(spacing: 10) {
                                Toggle(isOn: $enableFeature) {
                                    Text("Enable Feature")
                                }
                                .frame(width: 200)
                                .accessibilitySortPriority(1)
                                .accessibilityIdentifier("tc03_enable_toggle")

                                Button(action: {}) {
                                    Text("Apply Settings")
                                        .frame(width: 200, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilitySortPriority(2)
                                .accessibilityIdentifier("tc03_apply_button")
                            }
                            Text("VIOLATION: DOM reads Button then Toggle (sort priority), but Toggle is visually above Button")
                                .font(.caption)
                        }

                        Divider()

                        // TC-04: Horizontal buttons — middle button wrong in DOM via accessibilitySortPriority
                        Group {
                            Text("TC-04: Horizontal Buttons — Middle Swapped in DOM")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Visually Left, Center, Right. But sort priority makes DOM: Left(3), Right(2), Center(1) — adjacent pair Right→Center inverts")
                                .font(.caption)
                            HStack(spacing: 10) {
                                Button(action: {}) {
                                    Text("Left")
                                        .frame(width: 80, height: 44)
                                        .background(Color.red.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilitySortPriority(3)
                                .accessibilityIdentifier("tc04_left_btn")

                                Button(action: {}) {
                                    Text("Center")
                                        .frame(width: 80, height: 44)
                                        .background(Color.red.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilitySortPriority(1)
                                .accessibilityIdentifier("tc04_center_btn")

                                Button(action: {}) {
                                    Text("Right")
                                        .frame(width: 80, height: 44)
                                        .background(Color.red.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilitySortPriority(2)
                                .accessibilityIdentifier("tc04_right_btn")
                            }
                            Text("VIOLATION: DOM pair Right→Center inverts — Center is visually left of Right (same row, cx >10pt apart)")
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

                        // TC-05: Form with correct order (interactive elements)
                        Group {
                            Text("TC-05: Form Fields — Correct Order (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Interactive form fields in correct DOM order matching visual layout")
                                .font(.caption)
                            VStack(spacing: 8) {
                                TextField("Name", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityIdentifier("tc05_name")

                                TextField("Email", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityIdentifier("tc05_email")

                                TextField("Phone", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityIdentifier("tc05_phone")

                                Button(action: {}) {
                                    Text("Submit")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc05_submit")
                            }
                            .padding(.horizontal)
                            Text("PASS: VoiceOver reads Name, Email, Phone, Submit — DOM matches visual top-to-bottom order")
                                .font(.caption)
                        }

                        Divider()

                        // TC-06: Horizontal buttons in correct order
                        Group {
                            Text("TC-06: Horizontal Buttons — Correct Left-to-Right (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Buttons in correct DOM order matching visual left-to-right layout")
                                .font(.caption)
                            HStack(spacing: 10) {
                                Button(action: {}) {
                                    Text("Back")
                                        .frame(width: 80, height: 44)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc06_back")

                                Button(action: {}) {
                                    Text("Next")
                                        .frame(width: 80, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc06_next")

                                Button(action: {}) {
                                    Text("Skip")
                                        .frame(width: 80, height: 44)
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc06_skip")
                            }
                            Text("PASS: DOM order Back, Next, Skip matches visual left-to-right — no adjacent pair inversion")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Vertical buttons in correct order
                        Group {
                            Text("TC-07: Stacked Buttons — Correct Top-to-Bottom (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Vertically stacked interactive buttons in correct DOM and visual order")
                                .font(.caption)
                            VStack(spacing: 10) {
                                Button(action: {}) {
                                    Text("Option A")
                                        .frame(width: 200, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc07_option_a")

                                Button(action: {}) {
                                    Text("Option B")
                                        .frame(width: 200, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc07_option_b")

                                Button(action: {}) {
                                    Text("Option C")
                                        .frame(width: 200, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc07_option_c")
                            }
                            Text("PASS: DOM order A, B, C matches visual top-to-bottom — no inversion")
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

                        Text("These elements should be skipped by the Traversal Order check — no violation should be reported.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-08: Non-interactive StaticText elements in wrong order (filtered out)
                        Group {
                            Text("TC-08: Non-Interactive Text — Wrong Order (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Static text labels in wrong visual order — algorithm skips non-interactive StaticText/Image elements (design choice, not a bug)")
                                .font(.caption)
                            ZStack(alignment: .topLeading) {
                                Text("Third Label")
                                    .padding()
                                    .background(Color.orange.opacity(0.2))
                                    .offset(x: 0, y: 0)
                                    .accessibilityIdentifier("tc08_third_label")

                                Text("First Label")
                                    .padding()
                                    .background(Color.orange.opacity(0.2))
                                    .offset(x: 0, y: 90)
                                    .accessibilityIdentifier("tc08_first_label")

                                Text("Second Label")
                                    .padding()
                                    .background(Color.orange.opacity(0.2))
                                    .offset(x: 0, y: 45)
                                    .accessibilityIdentifier("tc08_second_label")
                            }
                            .frame(height: 130)
                            Text("SKIP: Non-interactive StaticText elements are filtered — description text position is a design choice")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: Header elements in wrong order (header trait filtered)
                        Group {
                            Text("TC-09: Header Elements — Trait Filtered (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Elements with header accessibility trait are skipped — headers are navigated via VoiceOver's heading rotor, not linear flow")
                                .font(.caption)
                            VStack(alignment: .leading, spacing: 4) {
                                Button(action: {}) {
                                    Text("Action Below Header")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.orange.opacity(0.3))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc09_action_below")

                                Text("Section Header")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .accessibilityAddTraits(.isHeader)
                                    .accessibilityIdentifier("tc09_header")
                            }
                            Text("SKIP: Header trait (bit 32768) causes element to be excluded from traversal check")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Elements under different parents (cross-parent not compared)
                        Group {
                            Text("TC-10: Different Parent Containers (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Buttons in separate parent containers — algorithm only compares siblings within the same parent, not across containers")
                                .font(.caption)
                            HStack(spacing: 10) {
                                VStack {
                                    Button(action: {}) {
                                        Text("Container 1 Btn")
                                            .font(.caption)
                                            .frame(width: 120, height: 44)
                                            .background(Color.orange.opacity(0.3))
                                            .foregroundColor(.primary)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityIdentifier("tc10_container1_btn")
                                }
                                .accessibilityElement(children: .contain)

                                VStack {
                                    Button(action: {}) {
                                        Text("Container 2 Btn")
                                            .font(.caption)
                                            .frame(width: 120, height: 44)
                                            .background(Color.orange.opacity(0.3))
                                            .foregroundColor(.primary)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityIdentifier("tc10_container2_btn")
                                }
                                .accessibilityElement(children: .contain)
                            }
                            Text("SKIP: Buttons are under different parent containers — cross-parent comparison not performed")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: Interactive buttons within 10pt row tolerance
                        Group {
                            Text("TC-11: Buttons Within Row Tolerance (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Interactive buttons with minor vertical offset (<10pt) — treated as same row, adjacent pair not flagged")
                                .font(.caption)
                            HStack(spacing: 16) {
                                Button(action: {}) {
                                    Text("Btn A")
                                        .frame(width: 70, height: 44)
                                        .background(Color.orange.opacity(0.3))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc11_btn_a")

                                Button(action: {}) {
                                    Text("Btn B")
                                        .frame(width: 70, height: 44)
                                        .background(Color.orange.opacity(0.3))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                }
                                .offset(y: 8)
                                .accessibilityIdentifier("tc11_btn_b")
                            }
                            Text("SKIP: 8pt vertical offset within 10pt row tolerance — DOM order right-of is correct on same row")
                                .font(.caption)
                        }

                        Divider()

                        // TC-12: Hidden interactive elements
                        Group {
                            Text("TC-12: Hidden Interactive Element (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("One button is hidden from accessibility — invisible elements filtered before comparison")
                                .font(.caption)
                            VStack(spacing: 8) {
                                Button(action: {}) {
                                    Text("Hidden Button")
                                        .frame(width: 200, height: 44)
                                        .background(Color.gray.opacity(0.3))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                }
                                .accessibilityHidden(true)
                                .accessibilityIdentifier("tc12_hidden_btn")

                                Button(action: {}) {
                                    Text("Visible Button")
                                        .frame(width: 200, height: 44)
                                        .background(Color.orange.opacity(0.3))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                }
                                .accessibilityIdentifier("tc12_visible_btn")
                            }
                            Text("SKIP: Hidden button (is_ax_element=false) excluded — only one focusable sibling remains, nothing to compare")
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
        TraversalOrderView()
    }
}
