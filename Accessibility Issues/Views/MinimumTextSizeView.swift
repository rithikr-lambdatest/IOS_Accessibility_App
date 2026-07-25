import SwiftUI

// TE-21951 — Minimum Text Size (Best Practice, minor).
// iOS: estimatedFontPt = frame.height / 1.1777; FAIL if < 11pt. Elements with
// frame.height >= 25pt (multi-line) are skipped. Only text-displaying elements
// (StaticText etc.) are checked. Fixed-size fonts don't scale, so small fixed
// fonts fire; Dynamic Type styles scale and pass.
struct MinimumTextSizeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Minimum Text Size")
                    .font(.title2).fontWeight(.bold)
                Text("Best Practice (Minor). Non-scalable text below ~11pt fails (estimatedFontPt = frame.height / 1.1777). Multi-line text (frame.height ≥ 25pt) is skipped. Prefer Dynamic Type so text scales.")
                    .font(.subheadline).foregroundColor(.secondary)

                Divider()

                Text("Violation Test Cases").font(.headline).foregroundColor(.red)
                card("V-01: 6pt", "systemFont size 6 — below 11pt", "v01_text_6pt") {
                    Text("Tiny 6pt text").font(.system(size: 6))
                }
                card("V-02: 8pt", "systemFont size 8 — below 11pt", "v02_text_8pt") {
                    Text("Tiny 8pt text").font(.system(size: 8))
                }
                card("V-03: 9pt", "systemFont size 9 — below 11pt", "v03_text_9pt") {
                    Text("Small 9pt text").font(.system(size: 9))
                }
                card("V-04: 10pt", "systemFont size 10 — below 11pt", "v04_text_10pt") {
                    Text("Small 10pt text").font(.system(size: 10))
                }

                Text("Pass Test Cases").font(.headline).foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                card("P-01: 11pt", "at the 11pt threshold", "p01_text_11pt") {
                    Text("11pt text").font(.system(size: 11))
                }
                card("P-02: 17pt", "Body default size", "p02_text_17pt") {
                    Text("17pt text").font(.system(size: 17))
                }
                card("P-03: Dynamic Type (.body)", "scales with user font setting — skipped", "p03_text_dynamic") {
                    Text("Dynamic Type body text").font(.body)
                }
                card("P-04: 20pt", "above threshold", "p04_text_20pt") {
                    Text("20pt text").font(.system(size: 20))
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
    NavigationView { MinimumTextSizeView() }
}
