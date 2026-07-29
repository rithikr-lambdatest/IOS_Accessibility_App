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
    @State private var wheelDup = 0
    @State private var wheelUnique = 0
    @State private var menuDup = 0
    @State private var tabDup = 0
    @State private var tabUnique = 0

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
                card("V-03: Picker (wheel) — duplicate 'Red'", "UIPickerView with two 'Red' options — the duplicate pair is flagged", "v03_picker_dup") {
                    Picker("Colour", selection: $wheelDup) {
                        Text("Red").tag(0)
                        Text("Red").tag(1)
                        Text("Blue").tag(2)
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                }
                card("V-04: TabView — duplicate 'Home'", "Tab bar with two 'Home' tabs — the duplicate pair is flagged", "v04_tabview_dup") {
                    TabView(selection: $tabDup) {
                        Text("Home 1").tabItem { Label("Home", systemImage: "house") }.tag(0)
                        Text("Home 2").tabItem { Label("Home", systemImage: "house.fill") }.tag(1)
                        Text("Profile").tabItem { Label("Profile", systemImage: "person") }.tag(2)
                    }
                    .frame(height: 160)
                }
                card("V-05: Menu Picker — duplicate 'Small'", "Pull-down menu with two 'Small' options — the duplicate pair is flagged", "v05_menu_dup") {
                    Picker("Size", selection: $menuDup) {
                        Text("Small").tag(0)
                        Text("Small").tag(1)
                        Text("Large").tag(2)
                    }
                    .pickerStyle(.menu)
                }

                Text("Pass Test Cases").font(.headline).foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                card("P-01: Segmented — unique labels", "[\"Monthly\", \"Yearly\", \"Lifetime\"] — all distinct", "p01_segmented_unique") {
                    SegmentedControl(items: ["Monthly", "Yearly", "Lifetime"])
                }
                card("P-03: Picker (wheel) — unique options", "Red / Green / Blue — all distinct", "p03_picker_unique") {
                    Picker("Colour", selection: $wheelUnique) {
                        Text("Red").tag(0)
                        Text("Green").tag(1)
                        Text("Blue").tag(2)
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                }
                card("P-04: TabView — unique tabs", "Home / Search / Profile — all distinct", "p04_tabview_unique") {
                    TabView(selection: $tabUnique) {
                        Text("Home").tabItem { Label("Home", systemImage: "house") }.tag(0)
                        Text("Search").tabItem { Label("Search", systemImage: "magnifyingglass") }.tag(1)
                        Text("Profile").tabItem { Label("Profile", systemImage: "person") }.tag(2)
                    }
                    .frame(height: 160)
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
