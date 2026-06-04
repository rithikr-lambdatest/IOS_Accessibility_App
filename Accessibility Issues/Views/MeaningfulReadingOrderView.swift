import SwiftUI

struct MeaningfulReadingOrderView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Meaningful Reading Order")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Fails when VoiceOver focus order diverges from logical content flow. Headings must precede the content they introduce, controls must follow the content they act on, and grouped content (cards, rows) must be announced as a contiguous unit. WCAG 1.3.2 + 2.4.3 (Level A), Severity Serious. Engine emits at most ONE issue per scan — the most impactful one.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Engine intentionally DROPS these as not-a-violation: same-row sibling swaps, sticky/floating CTAs (FAB, persistent footer), modal overlays, card/group interleaving, label-input pairs with wide inputs, and explicit RTL traversal.")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(6)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases — Divergence reported")
                            .font(.headline)
                            .foregroundColor(.red)

                        // V-01: CTA declared first in hierarchy, positioned visually at bottom
                        //   Visual (by bounds): Email → Password → Submit
                        //   Hierarchy: Submit → Email → Password
                        Group {
                            Text("V-01: CTA Announced Before the Form It Submits")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            ZStack(alignment: .topLeading) {
                                // Declared first → appears first in accessibility tree;
                                // but .position() puts it visually at the bottom.
                                Button("Submit") {}
                                    .frame(width: 280, height: 44)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .position(x: 150, y: 165)
                                    .accessibilityIdentifier("v01_button_submit")

                                TextField("Email", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 280)
                                    .position(x: 150, y: 30)
                                    .accessibilityIdentifier("v01_field_email")

                                SecureField("Password", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 280)
                                    .position(x: 150, y: 95)
                                    .accessibilityIdentifier("v01_field_password")
                            }
                            .frame(height: 200)
                        }

                        Divider()

                        // V-02: Two-column tangled order — cross-row, cross-column
                        //   Visual: Step 1 → Step 2 → Step 3 → Step 4 (row-major)
                        //   Hierarchy (HStack of VStacks): Step 1 → Step 3 → Step 2 → Step 4
                        Group {
                            Text("V-02: Two-Column Layout Read Column-Major")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            HStack(alignment: .top, spacing: 10) {
                                VStack(spacing: 10) {
                                    OrderCard(title: "Step 1", subtitle: "Create account")
                                        .accessibilityIdentifier("v02_step1")
                                    OrderCard(title: "Step 3", subtitle: "Confirm email")
                                        .accessibilityIdentifier("v02_step3")
                                }
                                VStack(spacing: 10) {
                                    OrderCard(title: "Step 2", subtitle: "Verify phone")
                                        .accessibilityIdentifier("v02_step2")
                                    OrderCard(title: "Step 4", subtitle: "Choose plan")
                                        .accessibilityIdentifier("v02_step4")
                                }
                            }
                        }

                        Divider()

                        // V-03: Heading declared LAST but visually positioned at TOP
                        //   Visual: heading (top) → body → CTA
                        //   Hierarchy: CTA → body → heading
                        Group {
                            Text("V-03: Heading Announced AFTER Its Section")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            ZStack(alignment: .topLeading) {
                                // CTA declared FIRST in hierarchy, positioned visually at the bottom of the card
                                Button("Buy now") {}
                                    .frame(width: 120, height: 36)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                                    .position(x: 80, y: 105)
                                    .accessibilityIdentifier("v03_button_buy")

                                // Body declared SECOND, positioned in the middle
                                Text("$9.99 / month — cancel anytime.")
                                    .position(x: 150, y: 60)
                                    .accessibilityIdentifier("v03_body")

                                // Heading declared LAST, positioned visually at the top
                                Text("Premium Plan")
                                    .font(.title3.bold())
                                    .position(x: 100, y: 20)
                                    .accessibilityIdentifier("v03_heading")
                            }
                            .frame(height: 140)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }

                        Divider()

                        // V-04: Total declared FIRST but visually positioned at BOTTOM
                        //   Visual: line items → total
                        //   Hierarchy: total → line items
                        Group {
                            Text("V-04: Receipt Total Announced Before Line Items")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            ZStack(alignment: .topLeading) {
                                // Total declared FIRST in hierarchy, positioned visually at the bottom
                                Text("Total: $15.00")
                                    .font(.headline)
                                    .position(x: 150, y: 130)
                                    .accessibilityIdentifier("v04_total")

                                Text("Item: Coffee — $4.50")
                                    .position(x: 150, y: 25)
                                    .accessibilityIdentifier("v04_item_coffee")
                                Text("Item: Sandwich — $8.00")
                                    .position(x: 150, y: 55)
                                    .accessibilityIdentifier("v04_item_sandwich")
                                Text("Item: Cookie — $2.50")
                                    .position(x: 150, y: 85)
                                    .accessibilityIdentifier("v04_item_cookie")
                            }
                            .frame(height: 160)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }

                        Divider()

                        // V-05: Card content interleaved
                        //   Visual: Card A (title above price) | Card B (title above price)
                        //   Hierarchy: Card A title → Card B title → Card A price → Card B price
                        Group {
                            Text("V-05: Card Content Interleaved Across Cards")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            ZStack(alignment: .topLeading) {
                                // Declaration order interleaves between cards
                                Text("Card A — Coffee")
                                    .position(x: 90, y: 30)
                                    .accessibilityIdentifier("v05_a_title")

                                Text("Card B — Tea")
                                    .position(x: 90, y: 110)
                                    .accessibilityIdentifier("v05_b_title")

                                Text("$4.50").bold()
                                    .position(x: 250, y: 30)
                                    .accessibilityIdentifier("v05_a_price")

                                Text("$3.50").bold()
                                    .position(x: 250, y: 110)
                                    .accessibilityIdentifier("v05_b_price")
                            }
                            .frame(height: 150)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Pass Test Cases — including intentional divergences
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pass Test Cases — Correct order OR intentional divergence")
                            .font(.headline)
                            .foregroundColor(Color(red: 0, green: 0.5, blue: 0))

                        // P-01: Default order matches visual order
                        Group {
                            Text("P-01: Default Stack — No Overrides Needed")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Welcome")
                                    .font(.headline)
                                Text("Sign in to continue to your dashboard.")
                                Button("Continue") {}
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .accessibilityIdentifier("p01_default_order")

                        }

                        Divider()

                        // P-02: Same-row sibling swap — engine drops these as below threshold
                        Group {
                            Text("P-02: Same-Row Sibling Swap (Intentional Drop)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            HStack(spacing: 10) {
                                Button("Cancel") {}
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                                    .accessibilitySortPriority(1)   // reordered, but same row
                                Button("Confirm") {}
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                                    .accessibilitySortPriority(10)  // announced first
                            }
                            .accessibilityIdentifier("p02_same_row_swap")

                        }

                        Divider()

                        // P-03: Sticky CTA / FAB — intentional divergence
                        Group {
                            Text("P-03: Sticky / Floating CTA (Intentional)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            ZStack(alignment: .bottomTrailing) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Messages")
                                        .font(.headline)
                                    ForEach(["Anna — Hey!", "Ben — On my way", "Carlos — Done"], id: \.self) { msg in
                                        Text(msg)
                                            .padding(.vertical, 2)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)

                                Button(action: {}) {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Circle().fill(Color.blue))
                                }
                                .padding()
                                .accessibilityLabel("Compose new message")
                            }
                            .accessibilityIdentifier("p03_sticky_fab")

                        }

                        Divider()

                        // P-04: Label-input pair with wide input — intentional
                        Group {
                            Text("P-04: Label–Input Pair with Wide Input (Intentional)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            HStack {
                                Text("Email")
                                    .frame(width: 80, alignment: .leading)
                                TextField("you@example.com", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .accessibilityIdentifier("p04_label_input_pair")

                        }

                        Divider()

                        // P-05: Card group read as contiguous unit
                        Group {
                            Text("P-05: Card Content Read as a Contiguous Unit")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            VStack(spacing: 10) {
                                CombinedProductCard(title: "Card A — Coffee", price: "$4.50", id: "p05_cardA")
                                CombinedProductCard(title: "Card B — Tea", price: "$3.50", id: "p05_cardB")
                            }

                        }

                        Divider()

                        // P-06: accessibilityElements ordered explicitly
                        Group {
                            Text("P-06: Explicit `accessibilityElements` Order")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            VStack(spacing: 10) {
                                TextField("Email", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .accessibilitySortPriority(3)
                                SecureField("Password", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .accessibilitySortPriority(2)
                                Button("Continue") {}
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .accessibilitySortPriority(1)
                            }
                            .accessibilityIdentifier("p06_explicit_elements")

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

private struct OrderCard: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline).bold()
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(6)
    }
}

private struct ProductCard: View {
    let title: String
    let price: String
    let titlePriority: Double
    let pricePriority: Double
    let id: String

    var body: some View {
        HStack {
            Text(title)
                .accessibilitySortPriority(titlePriority)
            Spacer()
            Text(price)
                .bold()
                .accessibilitySortPriority(pricePriority)
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(6)
        .accessibilityIdentifier(id)
    }
}

private struct CombinedProductCard: View {
    let title: String
    let price: String
    let id: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(price).bold()
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(6)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(id)
    }
}

#Preview {
    NavigationView {
        MeaningfulReadingOrderView()
    }
}
