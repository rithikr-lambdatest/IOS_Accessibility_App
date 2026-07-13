import SwiftUI
import UIKit

// =====================================================================
// MEANINGFUL READING ORDER (WCAG 1.3.2 Meaningful Sequence)
// =====================================================================
// iOS XCUITest dumps preserve `accessibilityElements` order. So each
// violation lays its UIKit views out in the CORRECT visual order but
// overrides `container.accessibilityElements` to the WRONG order, which
// is what VoiceOver / the evaluator reads. Passes use natural order and
// do NOT override accessibilityElements.
// Every element sets isAccessibilityElement = true and accessibilityLabel.
// =====================================================================

// One renderable element in a reading-order card.
private struct ROElement {
    enum Kind { case title, label, price, error, body, button, input, toggle }
    let kind: Kind
    let text: String
}

// A single test card: elements are given in CORRECT visual (top-to-bottom)
// order; `readingOrder` (when set) is the WRONG index order forced onto
// accessibilityElements to create the violation.
private struct ROCard: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let elements: [ROElement]
    var readingOrder: [Int]? = nil
}

// UIKit-backed vertical layout that can override accessibilityElements order.
private struct UIKitReadingOrder: UIViewRepresentable {
    let elements: [ROElement]
    var readingOrder: [Int]? = nil

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.isAccessibilityElement = false

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])

        // Build in visual order; collect the focusable element per row.
        var focusables: [UIView] = []
        for element in elements {
            let (view, focusable) = Self.makeElement(element)
            stack.addArrangedSubview(view)
            focusables.append(focusable)
        }

        // Violation: force the wrong reading order. Pass: leave natural order.
        if let order = readingOrder {
            container.accessibilityElements = order.map { focusables[$0] }
        }
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
        let width = proposal.width ?? (UIScreen.main.bounds.width - 64)
        let fitted = uiView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return CGSize(width: width, height: fitted.height)
    }

    // Returns (view added to the stack, focusable accessibility element).
    private static func makeElement(_ element: ROElement) -> (UIView, UIView) {
        switch element.kind {
        case .title, .label, .price, .error, .body:
            let label = UILabel()
            label.text = element.text
            label.numberOfLines = 0
            switch element.kind {
            case .title: label.font = .boldSystemFont(ofSize: 17)
            case .price: label.font = .boldSystemFont(ofSize: 20)
            case .error: label.font = .systemFont(ofSize: 14); label.textColor = .systemRed
            case .body:  label.font = .systemFont(ofSize: 14)
            default:     label.font = .systemFont(ofSize: 15)
            }
            label.isAccessibilityElement = true
            label.accessibilityLabel = element.text
            return (label, label)
        case .button:
            let button = UIButton(type: .system)
            button.setTitle(element.text, for: .normal)
            button.contentHorizontalAlignment = .leading
            button.isAccessibilityElement = true
            button.accessibilityLabel = element.text
            button.accessibilityTraits = .button
            return (button, button)
        case .input:
            let field = UITextField()
            field.placeholder = element.text
            field.borderStyle = .roundedRect
            field.isAccessibilityElement = true
            field.accessibilityLabel = element.text
            return (field, field)
        case .toggle:
            let row = UIStackView()
            row.axis = .horizontal
            row.alignment = .center
            let label = UILabel()
            label.text = element.text
            label.font = .systemFont(ofSize: 15)
            let toggle = UISwitch()
            toggle.isOn = true
            row.addArrangedSubview(label)
            row.addArrangedSubview(UIView())      // spacer
            row.addArrangedSubview(toggle)
            row.isAccessibilityElement = true
            row.accessibilityLabel = "\(element.text), on"
            row.accessibilityTraits = .button
            return (row, row)
        }
    }
}

struct MeaningfulReadingOrderView: View {

    // ---------- VIOLATIONS (visual order correct, a11y order wrong) ----------
    private static let violations: [ROCard] = [
        ROCard(
            id: "v01_price_before_name",
            title: "V-01: Price Before Name",
            subtitle: "Visual: name → price → action. VoiceOver reads: price → name → action.",
            elements: [
                ROElement(kind: .title, text: "Wireless Headphones"),
                ROElement(kind: .price, text: "$79.99"),
                ROElement(kind: .button, text: "Add to Cart")
            ],
            readingOrder: [1, 0, 2]
        ),
        ROCard(
            id: "v02_input_before_label",
            title: "V-02: Input Before Label",
            subtitle: "Visual: label → input. VoiceOver reads: input → label.",
            elements: [
                ROElement(kind: .label, text: "Email"),
                ROElement(kind: .input, text: "you@example.com")
            ],
            readingOrder: [1, 0]
        ),
        ROCard(
            id: "v03_controls_before_song",
            title: "V-03: Controls Before Song",
            subtitle: "Visual: title → artist → controls. VoiceOver reads: controls → title → artist.",
            elements: [
                ROElement(kind: .title, text: "Bohemian Rhapsody"),
                ROElement(kind: .body, text: "Queen"),
                ROElement(kind: .button, text: "Previous"),
                ROElement(kind: .button, text: "Play"),
                ROElement(kind: .button, text: "Next")
            ],
            readingOrder: [2, 3, 4, 0, 1]
        ),
        ROCard(
            id: "v04_amount_before_merchant",
            title: "V-04: Amount Before Merchant",
            subtitle: "Visual: merchant → amount. VoiceOver reads: amount → merchant.",
            elements: [
                ROElement(kind: .title, text: "Starbucks"),
                ROElement(kind: .price, text: "-$45.99")
            ],
            readingOrder: [1, 0]
        ),
        ROCard(
            id: "v05_error_before_field",
            title: "V-05: Error Before Field",
            subtitle: "Visual: label → input → error. VoiceOver reads: error → label → input.",
            elements: [
                ROElement(kind: .label, text: "Email"),
                ROElement(kind: .input, text: "you@example.com"),
                ROElement(kind: .error, text: "Error: Please enter a valid email address")
            ],
            readingOrder: [2, 0, 1]
        ),
        ROCard(
            id: "v06_steps_out_of_order",
            title: "V-06: Steps Out Of Order",
            subtitle: "Visual: 1 → 2 → 3. VoiceOver reads: 3 → 1 → 2.",
            elements: [
                ROElement(kind: .body, text: "Step 1: Boil the kettle"),
                ROElement(kind: .body, text: "Step 2: Pour into the mug"),
                ROElement(kind: .body, text: "Step 3: Add water and stir")
            ],
            readingOrder: [2, 0, 1]
        ),
        ROCard(
            id: "v07_action_before_content",
            title: "V-07: Action Before Content",
            subtitle: "Visual: hotel → details → action. VoiceOver reads: action → hotel → details.",
            elements: [
                ROElement(kind: .title, text: "Grand Plaza Hotel"),
                ROElement(kind: .body, text: "Downtown • 4.6 ★ • Free cancellation"),
                ROElement(kind: .button, text: "Book Now")
            ],
            readingOrder: [2, 0, 1]
        ),
        ROCard(
            id: "v08_engagement_before_post",
            title: "V-08: Engagement Before Post",
            subtitle: "Visual: post → engagement. VoiceOver reads: engagement → post.",
            elements: [
                ROElement(kind: .body, text: "Just had the best coffee of my life at this tiny place downtown ☕"),
                ROElement(kind: .title, text: "2.4K likes • 312 comments")
            ],
            readingOrder: [1, 0]
        )
    ]

    // ---------- PASSES (natural order, no accessibilityElements override) ----------
    private static let passes: [ROCard] = [
        ROCard(
            id: "p01_login_form",
            title: "P-01: Login Form (Pass)",
            subtitle: "Label → input pairs in natural order, action last.",
            elements: [
                ROElement(kind: .label, text: "Email"),
                ROElement(kind: .input, text: "you@example.com"),
                ROElement(kind: .label, text: "Password"),
                ROElement(kind: .input, text: "Password"),
                ROElement(kind: .button, text: "Sign In")
            ]
        ),
        ROCard(
            id: "p02_news_article",
            title: "P-02: News Article (Pass)",
            subtitle: "Headline → byline → body in reading order.",
            elements: [
                ROElement(kind: .title, text: "City Council Approves New Transit Plan"),
                ROElement(kind: .body, text: "By Jane Doe • July 9, 2026"),
                ROElement(kind: .body, text: "The council voted 7-2 on Tuesday to fund the expansion of the light-rail network over the next five years.")
            ]
        ),
        ROCard(
            id: "p03_product_card",
            title: "P-03: Product Card (Pass)",
            subtitle: "Name → price → action in natural order.",
            elements: [
                ROElement(kind: .title, text: "Wireless Headphones"),
                ROElement(kind: .price, text: "$79.99"),
                ROElement(kind: .button, text: "Add to Cart")
            ]
        ),
        ROCard(
            id: "p04_settings_page",
            title: "P-04: Settings Page (Pass)",
            subtitle: "Section title first, then each labelled control.",
            elements: [
                ROElement(kind: .title, text: "Settings"),
                ROElement(kind: .toggle, text: "Wi-Fi"),
                ROElement(kind: .toggle, text: "Bluetooth")
            ]
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Meaningful Reading Order — meaningful-sequence")
                        .font(.title2).fontWeight(.bold)
                    Text("WCAG 1.3.2 (A), Severity Serious. iOS XCUITest preserves accessibilityElements order. Each violation lays views out in the CORRECT visual order but overrides accessibilityElements to the WRONG order; passes use natural order with no override.")
                        .font(.subheadline).foregroundColor(.secondary)
                }

                Divider()

                Text("Violation Test Cases — reading order overridden to wrong sequence")
                    .font(.headline).foregroundColor(.red)
                ForEach(Self.violations) { card in
                    cardView(card)
                }

                Text("Pass Test Cases — natural order, no override")
                    .font(.headline).foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                ForEach(Self.passes) { card in
                    cardView(card)
                }
            }
            .padding()
        }
        .navigationTitle("")
    }

    private func cardView(_ card: ROCard) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(card.title).font(.subheadline).fontWeight(.semibold)
            Text(card.subtitle).font(.caption).foregroundColor(.secondary)
            UIKitReadingOrder(elements: card.elements, readingOrder: card.readingOrder)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        MeaningfulReadingOrderView()
    }
}
