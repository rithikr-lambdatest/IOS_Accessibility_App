import SwiftUI
import UIKit

// TE-21951 — Unique Option Names (WCAG 4.1.2 + 1.3.1 A, moderate).
// iOS: options within a group (SegmentedControl, TabBar, RadioGroup, Picker…)
// must have distinct labels. Duplicate sibling labels within one group fail;
// the same labels across separate groups are fine.

// UISegmentedControl with arbitrary (possibly duplicate) segment titles.
private struct SegmentedControl: UIViewRepresentable {
    let items: [String]
    func makeUIView(context: Context) -> UISegmentedControl {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        return control
    }
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {}
}

struct UniqueOptionNamesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Unique Option Names")
                    .font(.title2).fontWeight(.bold)
                Text("WCAG 4.1.2 + 1.3.1 (A), Moderate. Options within a selection group (segmented control, tab bar, picker) must have distinct accessible names. Same labels across separate groups are fine.")
                    .font(.subheadline).foregroundColor(.secondary)

                Divider()

                Text("Violation Test Cases").font(.headline).foregroundColor(.red)
                card("V-01: Segmented — duplicate 'Option'", "[\"Option\", \"Option\", \"Different\"] — the 'Option' pair is flagged", "v01_segmented_dup_option") {
                    SegmentedControl(items: ["Option", "Option", "Different"])
                }
                card("V-02: Segmented — three 'Tab'", "[\"Tab\", \"Tab\", \"Tab\"] — all three flagged", "v02_segmented_all_tab") {
                    SegmentedControl(items: ["Tab", "Tab", "Tab"])
                }

                Text("Pass Test Cases").font(.headline).foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                card("P-01: Segmented — unique labels", "[\"Monthly\", \"Yearly\", \"Lifetime\"] — all distinct", "p01_segmented_unique") {
                    SegmentedControl(items: ["Monthly", "Yearly", "Lifetime"])
                }
                card("P-02: Two separate groups, same labels", "Same 'Yes'/'No' in DIFFERENT segmented controls is fine", "p02_segmented_separate_groups") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notifications").font(.caption)
                        SegmentedControl(items: ["Yes", "No"])
                            .accessibilityIdentifier("p02_group_notifications")
                        Text("Marketing emails").font(.caption)
                        SegmentedControl(items: ["Yes", "No"])
                            .accessibilityIdentifier("p02_group_marketing")
                    }
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
    NavigationView { UniqueOptionNamesView() }
}
