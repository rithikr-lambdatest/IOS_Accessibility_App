import SwiftUI
import UIKit

// TE-21951 — Invalid Range Values (WCAG 4.1.2 A, serious).
// iOS: an adjustable/range control FAILS if it exposes no programmatic value
// (no accessibilityValue and no text). Native UISlider/UIStepper auto-populate
// their value → always pass. A custom .adjustable view with no value fails.

// A draggable custom slider that renders ARBITRARY min/max/current — including
// invalid combinations a native UISlider would clamp (current beyond max, below
// min, min == max, inverted). It's an .adjustable element with NO accessibilityValue,
// so it's the iOS violation. NOTE: the iOS rule only flags the missing value; the
// min/max/current here are illustrative (they mirror the Android scenarios) — iOS
// cannot detect out-of-range values from the accessibility tree.
private final class ScenarioSlider: UIView {
    private let minVal: Float
    private let maxVal: Float
    private var current: Float

    private let track = UIView()
    private let thumb = UIView()

    init(min: Float, max: Float, current: Float, value: String? = nil) {
        self.minVal = min
        self.maxVal = max
        self.current = current
        super.init(frame: .zero)

        track.backgroundColor = .systemGray3
        track.layer.cornerRadius = 2
        addSubview(track)

        thumb.backgroundColor = .systemBlue
        thumb.layer.cornerRadius = 12
        thumb.layer.borderWidth = 2
        thumb.layer.borderColor = UIColor.white.cgColor
        addSubview(thumb)

        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))

        isAccessibilityElement = true
        accessibilityTraits = .adjustable
        // value == nil → no accessibilityValue → violation.
        // value != nil → exposes a value → passes (even if the range is invalid).
        accessibilityValue = value
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private var fraction: CGFloat {
        if maxVal == minVal { return 0.5 }
        return CGFloat((current - minVal) / (maxVal - minVal))
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let h = bounds.height
        track.frame = CGRect(x: 0, y: h / 2 - 2, width: bounds.width, height: 4)
        let thumbSize: CGFloat = 24
        // Clamp slightly past the edges so out-of-range positions are visible.
        let clamped = Swift.max(-0.08, Swift.min(1.08, fraction))
        let cx = clamped * bounds.width
        thumb.frame = CGRect(x: cx - thumbSize / 2, y: h / 2 - thumbSize / 2, width: thumbSize, height: thumbSize)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let x = gesture.location(in: self).x
        let frac = Swift.max(0, Swift.min(1, x / Swift.max(bounds.width, 1)))
        current = minVal + Float(frac) * (maxVal - minVal)
        setNeedsLayout()
    }
}

// A real, draggable UISlider that always exposes a fixed value → pass.
private final class FixedValueSlider: UISlider {
    var fixedValue: String = "75%"
    override var accessibilityValue: String? {
        get { fixedValue }
        set { }
    }
}

// Draggable scenario slider with no accessibilityValue → violation.
private struct ScenarioSliderView: UIViewRepresentable {
    let min: Float
    let max: Float
    let current: Float
    var value: String? = nil   // non-nil → exposes accessibilityValue → passes
    func makeUIView(context: Context) -> UIView {
        ScenarioSlider(min: min, max: max, current: current, value: value)
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// Draggable slider that exposes a value → pass.
private struct AdjustableWithValue: UIViewRepresentable {
    let value: String
    func makeUIView(context: Context) -> UISlider {
        let slider = FixedValueSlider()
        slider.fixedValue = value
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 75
        slider.accessibilityLabel = "Volume"
        return slider
    }
    func updateUIView(_ uiView: UISlider, context: Context) {}
}

struct InvalidRangeValuesView: View {
    @State private var sliderValue = 0.5
    @State private var stepperValue = 3.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Invalid Range Values")
                    .font(.title2).fontWeight(.bold)
                Text("WCAG 4.1.2 (A), Serious. An adjustable/range control fails if it exposes no programmatic value. Native UISlider/UIStepper auto-populate their value and pass; custom .adjustable views without a value fail.")
                    .font(.subheadline).foregroundColor(.secondary)

                Divider()

                Text("Violation Test Cases").font(.headline).foregroundColor(.red)
                Text("All four fail for the same iOS reason — an .adjustable control with no accessibilityValue. The min/max/current mirror the Android scenarios; iOS can't read them, so they're illustrative.")
                    .font(.caption).foregroundColor(.orange)
                card("V-01: current > max (0, 100, 150)", "Thumb sits beyond the track end — value exceeds max.", "v01_current_over_max") {
                    ScenarioSliderView(min: 0, max: 100, current: 150)
                }
                card("V-02: min > max (100, 50, 75)", "Inverted range — min is greater than max.", "v02_min_over_max") {
                    ScenarioSliderView(min: 100, max: 50, current: 75)
                }
                card("V-03: min == max (50, 50, 50)", "Zero-width range — min equals max.", "v03_min_equals_max") {
                    ScenarioSliderView(min: 50, max: 50, current: 50)
                }
                card("V-04: current < min (0, 100, -10)", "Thumb sits before the track start — value below min.", "v04_current_below_min") {
                    ScenarioSliderView(min: 0, max: 100, current: -10)
                }
                card("V-05: min > max BUT has value (100, 50, 75)", "Same inverted range as V-02, but it exposes accessibilityValue = \"75\". iOS PASSES it — the rule only checks value presence, not range validity. (Android would still FAIL this.)", "v05_min_over_max_with_value") {
                    ScenarioSliderView(min: 100, max: 50, current: 75, value: "75")
                }

                Text("Pass Test Cases").font(.headline).foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                card("P-01: Adjustable with value", "Custom view exposes accessibilityValue = \"75%\"", "p01_adjustable_with_value") {
                    AdjustableWithValue(value: "75%")
                }
                card("P-02: Native UISlider", "SwiftUI Slider auto-populates its value", "p02_native_slider") {
                    Slider(value: $sliderValue).accessibilityLabel("Brightness")
                }
                card("P-03: Native UIStepper", "SwiftUI Stepper auto-populates its value", "p03_native_stepper") {
                    Stepper("Quantity: \(Int(stepperValue))", value: $stepperValue, in: 0...10)
                }
            }
            .padding()
        }
        .navigationTitle("")
    }

    @ViewBuilder
    private func card(_ id: String, _ desc: String, _ identifier: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(id).font(.subheadline).fontWeight(.semibold)
            Text(desc).font(.caption).foregroundColor(.secondary)
            content().accessibilityIdentifier(identifier)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationView { InvalidRangeValuesView() }
}
