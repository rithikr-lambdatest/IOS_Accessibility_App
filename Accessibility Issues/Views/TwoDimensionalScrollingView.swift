import SwiftUI

struct TwoDimensionalScrollingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // TE-7944: Two-Dimensional Scrolling
                VStack(alignment: .leading, spacing: 20) {
                    Text("Two-Dimensional Scrolling")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Content must be accessible without requiring simultaneous horizontal and vertical scrolling. Single-direction scrolling containers should be used. Content should not lose information when zoomed in or viewed at different screen sizes.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: Both-axis scrollable container with wide + tall content
                        Group {
                            Text("TC-01: Both-Axis Scrollable Container")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Content placed in a container that scrolls both horizontally and vertically — user must scroll in two directions to access all content")
                                .font(.caption)
                            ScrollView([.horizontal, .vertical]) {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(0..<3) { row in
                                        HStack(spacing: 10) {
                                            ForEach(0..<5) { col in
                                                Text("Item \(row)-\(col)")
                                                    .padding(8)
                                                    .background(Color.red.opacity(0.2))
                                                    .cornerRadius(4)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                            .frame(height: 150)
                            .border(Color.red, width: 1)
                            .accessibilityIdentifier("tc01_both_axis_scroll")
                            Text("⚠️ VIOLATION: Content requires both horizontal and vertical scrolling to be fully accessible")
                                .font(.caption)
                        }

                        Divider()

                        // TC-02: Fixed-width content wider than screen causing horizontal scroll
                        Group {
                            Text("TC-02: Fixed-Width Content Wider Than Screen")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("A table with fixed column widths that exceed screen width — forces horizontal scrolling alongside vertical page scroll")
                                .font(.caption)
                            ScrollView(.horizontal) {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack(spacing: 0) {
                                        Text("Name").frame(width: 200).fontWeight(.bold)
                                        Text("Email").frame(width: 250).fontWeight(.bold)
                                        Text("Phone").frame(width: 200).fontWeight(.bold)
                                        Text("Address").frame(width: 300).fontWeight(.bold)
                                    }
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.3))

                                    ForEach(0..<3) { i in
                                        HStack(spacing: 0) {
                                            Text("User \(i + 1)").frame(width: 200)
                                            Text("user\(i + 1)@example.com").frame(width: 250)
                                            Text("+1-555-000\(i)").frame(width: 200)
                                            Text("123 Street Name, City, State").frame(width: 300)
                                        }
                                        .padding(.vertical, 2)
                                    }
                                }
                                .padding()
                            }
                            .frame(height: 160)
                            .border(Color.red, width: 1)
                            .accessibilityIdentifier("tc02_fixed_width_table")
                            Text("⚠️ VIOLATION: Fixed-width table forces horizontal scrolling on top of vertical page scroll")
                                .font(.caption)
                        }

                        Divider()

                        // TC-03: Image gallery with no wrapping
                        Group {
                            Text("TC-03: Non-Wrapping Image Gallery")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Image gallery in a horizontal scroll within a vertical page — requires two-axis scrolling to see all images")
                                .font(.caption)
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack(spacing: 12) {
                                    ForEach(0..<5) { i in
                                        VStack {
                                            Image(systemName: "photo.fill")
                                                .font(.system(size: 50))
                                                .foregroundColor(.gray)
                                                .frame(width: 120, height: 120)
                                                .background(Color.red.opacity(0.1))
                                                .cornerRadius(8)
                                            Text("Photo \(i + 1)")
                                                .font(.caption2)
                                        }
                                    }
                                }
                                .padding()
                            }
                            .frame(height: 170)
                            .border(Color.red, width: 1)
                            .accessibilityIdentifier("tc03_non_wrapping_gallery")
                            Text("⚠️ VIOLATION: Gallery requires horizontal scrolling within a vertically scrollable page")
                                .font(.caption)
                        }

                        Divider()

                        // TC-05: Wide form with no responsive layout
                        Group {
                            Text("TC-05: Wide Form with No Responsive Layout")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Form fields laid out in a fixed-width horizontal row that exceeds screen width")
                                .font(.caption)
                            ScrollView(.horizontal) {
                                HStack(spacing: 16) {
                                    VStack(alignment: .leading) {
                                        Text("First Name").font(.caption)
                                        TextField("", text: .constant(""))
                                            .textFieldStyle(.roundedBorder)
                                            .frame(width: 180)
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Last Name").font(.caption)
                                        TextField("", text: .constant(""))
                                            .textFieldStyle(.roundedBorder)
                                            .frame(width: 180)
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Email").font(.caption)
                                        TextField("", text: .constant(""))
                                            .textFieldStyle(.roundedBorder)
                                            .frame(width: 220)
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Phone").font(.caption)
                                        TextField("", text: .constant(""))
                                            .textFieldStyle(.roundedBorder)
                                            .frame(width: 180)
                                    }
                                }
                                .padding()
                            }
                            .frame(height: 80)
                            .border(Color.red, width: 1)
                            .accessibilityIdentifier("tc05_wide_form_no_responsive")
                            Text("⚠️ VIOLATION: Fixed-width form fields force horizontal scrolling")
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

                        // TC-06: Single-direction vertical scroll
                        Group {
                            Text("TC-06: Single-Direction Vertical Scroll (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Content flows vertically and wraps within screen width — only vertical scrolling needed")
                                .font(.caption)
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(0..<2) { i in
                                    Text("This is a paragraph of content that wraps naturally within the screen width. Item \(i + 1).")
                                        .padding(8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.green.opacity(0.1))
                                        .cornerRadius(4)
                                }
                            }
                            .accessibilityIdentifier("tc06_vertical_scroll_only")
                            Text("✅ PASS: Content wraps and only requires vertical scrolling")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Single-direction horizontal scroll
                        Group {
                            Text("TC-07: Single-Direction Horizontal Scroll (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Content scrolls only horizontally in a fixed-height container — single-axis scrolling is not a violation")
                                .font(.caption)
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack(spacing: 12) {
                                    ForEach(0..<5) { i in
                                        Text("Card \(i + 1)")
                                            .padding()
                                            .frame(width: 100, height: 60)
                                            .background(Color.green.opacity(0.2))
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 80)
                            .accessibilityIdentifier("tc07_horizontal_scroll_only")
                            Text("✅ PASS: Content scrolls only in one direction (horizontal) — not a violation")
                                .font(.caption)
                        }

                        Divider()

                        // TC-08: Responsive wrapping grid
                        Group {
                            Text("TC-08: Responsive Wrapping Grid (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Grid items wrap to next row when screen width is exceeded — no horizontal scroll needed")
                                .font(.caption)
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                                ForEach(0..<6) { i in
                                    Text("Item \(i + 1)")
                                        .padding(8)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green.opacity(0.2))
                                        .cornerRadius(4)
                                }
                            }
                            .accessibilityIdentifier("tc08_responsive_grid")
                            Text("✅ PASS: Grid adapts to screen width using adaptive layout")
                                .font(.caption)
                        }

                        Divider()

                        // TC-09: Responsive stacked form
                        Group {
                            Text("TC-09: Responsive Stacked Form (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Form fields stacked vertically — adapts to any screen width")
                                .font(.caption)
                            VStack(alignment: .leading, spacing: 12) {
                                VStack(alignment: .leading) {
                                    Text("First Name").font(.caption)
                                    TextField("", text: .constant(""))
                                        .textFieldStyle(.roundedBorder)
                                }
                                VStack(alignment: .leading) {
                                    Text("Email").font(.caption)
                                    TextField("", text: .constant(""))
                                        .textFieldStyle(.roundedBorder)
                                }
                                VStack(alignment: .leading) {
                                    Text("Phone").font(.caption)
                                    TextField("", text: .constant(""))
                                        .textFieldStyle(.roundedBorder)
                                }
                            }
                            .accessibilityIdentifier("tc09_responsive_form")
                            Text("✅ PASS: Form fields stack vertically, no horizontal scroll needed")
                                .font(.caption)
                        }

                        Divider()

                        // TC-10: Wrapping text content
                        Group {
                            Text("TC-10: Wrapping Text Content (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Long text content that wraps within the container — no horizontal overflow")
                                .font(.caption)
                            Text("This is a long paragraph of text that demonstrates proper text wrapping behavior. The text flows naturally within the available width and does not require any horizontal scrolling to read the complete content. Users can simply scroll vertically to read all the content on this page.")
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                                .accessibilityIdentifier("tc10_wrapping_text")
                            Text("✅ PASS: Text wraps within container width")
                                .font(.caption)
                        }

                        Divider()

                        // TC-11: Responsive table using vertical layout
                        Group {
                            Text("TC-11: Responsive Table as Vertical Cards (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Table data presented as stacked cards instead of wide columns — no horizontal scroll")
                                .font(.caption)
                            VStack(spacing: 8) {
                                ForEach(0..<3) { i in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("User \(i + 1)").fontWeight(.bold)
                                        Text("Email: user\(i + 1)@example.com")
                                        Text("Phone: +1-555-000\(i)")
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                            .accessibilityIdentifier("tc11_responsive_cards")
                            Text("✅ PASS: Data presented in stacked cards — single-direction scroll only")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Skip Condition Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Skip Condition Test Cases")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("These elements should be skipped — two-dimensional scrolling is acceptable in these cases.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-12: Map view (essential two-axis scrolling)
                        Group {
                            Text("TC-12: Map View — Essential Two-Axis Scrolling (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Maps inherently require panning in all directions — two-dimensional scrolling is essential for functionality")
                                .font(.caption)
                            ZStack {
                                Color.blue.opacity(0.1)
                                VStack {
                                    Image(systemName: "map.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                    Text("Interactive Map")
                                        .font(.caption)
                                }
                            }
                            .frame(height: 120)
                            .cornerRadius(8)
                            .accessibilityIdentifier("tc12_map_essential_2d")
                            Text("⏭️ SKIP: Map requires two-axis panning — essential for functionality")
                                .font(.caption)
                        }

                        Divider()

                        // TC-13: Canvas/drawing area
                        Group {
                            Text("TC-13: Drawing Canvas — Essential Two-Axis Interaction (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Drawing canvas requires free-form interaction in all directions")
                                .font(.caption)
                            ZStack {
                                Color.orange.opacity(0.1)
                                VStack {
                                    Image(systemName: "pencil.and.scribble")
                                        .font(.system(size: 40))
                                        .foregroundColor(.orange)
                                    Text("Drawing Canvas")
                                        .font(.caption)
                                }
                            }
                            .frame(height: 120)
                            .cornerRadius(8)
                            .accessibilityIdentifier("tc13_canvas_essential_2d")
                            Text("⏭️ SKIP: Canvas requires free-form two-axis interaction — essential for functionality")
                                .font(.caption)
                        }

                        Divider()

                        // TC-14: Hidden content not visible on screen
                        Group {
                            Text("TC-14: Hidden Content Not Visible (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Off-screen content that is not currently displayed — no scrolling check needed")
                                .font(.caption)
                            Text("This content is visible, but imagine hidden off-screen content")
                                .padding()
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(8)
                                .accessibilityHidden(true)
                                .accessibilityIdentifier("tc14_hidden_content")
                            Text("⏭️ SKIP: Content not visible on screen — not applicable for scrolling check")
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
        TwoDimensionalScrollingView()
    }
}
