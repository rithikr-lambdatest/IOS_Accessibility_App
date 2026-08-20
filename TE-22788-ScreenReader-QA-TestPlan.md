# TE-22788 — iOS Screen Reader Automation · QA Test Plan

**Feature:** iOS VoiceOver Screen Reader Automation (auto-report + linear navigation)
**RFC:** internal-docs PR #2642 · **Ticket:** TE-22788 · **Parity target:** BrowserStack Screen Reader Automation
**Fixture app:** `Accessibility Issues` (iOS) → **"Screen Reader Automation"** screen (`ScreenReaderTestView`) + **"Open Linear-Navigation Fixture"** (`ScreenReaderLinearNavView`)

> How to use: enable the scan on an iOS app-automation session with
> `accessibility: true` + `accessibilityOptions.screenReaderAutomation.autoReport: true`
> (and/or `.linearNavigation: true`). Navigate the fixture screens, then verify the
> generated report's `allIssues` / `passes` against the expectations below. Every element
> carries an `accessibilityIdentifier` (`sr_r<rule>_<v|p><nn>_<slug>`) for deterministic targeting.

---

## 0. Ground-truth method

For each element, capture the **actual VoiceOver announcement on a real device** (Settings → Accessibility → VoiceOver, or the BrowserStack/LT session) and treat that as truth. The scan's `spokenOutput` should equal what VoiceOver says; `expectedOutput` should equal the intended fix. **Do not trust the fixture labels alone — verify against the device**, because several rules depend on how XCUITest snapshots expose the element (see §7 Known-ambiguity checks).

Pass/fail for a test case = (scan verdict matches expected verdict) **AND** (`spokenOutput`, `expectedOutput`, `boundsInScreen`, `traversalIndex` are all correct).

---

## 1. Rule coverage matrix (fixture → expected verdict)

| Case ID (`accessibilityIdentifier`) | Rule | Expected | What to verify in the report |
|---|---|---|---|
| `sr_r1_v02_textfield` | R1 Interactive Focus Order | **FAIL** (critical) | flagged; confirmed firing (`label=""`, `spokenOutput=""`, `traits=""`) |
| `sr_r1_v03_securefield` | R1 | **FAIL** | confirmed firing, same property shape |
| `sr_r1_p02_textfield_labeled` | R1 | **PASS** | the only meaningful negative control — same class as V-02, differs only in the label |
| `sr_r2_v02_empty_shape` | R2 Non-Interactive Focus Order | **FAIL** (serious) | forced-accessible shape, no name — *does NOT fire today*; record the captured `class`/`traits` |
| `sr_r2_v03_empty_forced_text` | R2 | **FAIL** | forced element + blank label — *does NOT fire today*; record `class`/`traits` |
| `sr_r2_v05_empty_sized_text` | R2 | **FAIL** | **dev-app construction**: `Text("")` + frame + background + `children: .ignore` + empty label. This is the element that fires R2 in `ScreenReaderTestApp` → if it fires here, V-01..V-03 are fixture problems, not engine bugs |
| `sr_r2_v06_empty_divider` | R2 | **FAIL** | **dev-app construction**: forced-accessible `Divider()` with empty label |
| *(no identifier)* R2 V-07 | R2 | **FAIL** | identical to V-05 but **without** an `accessibilityIdentifier` — control for "engine uses identifier as fallback name" |
| *(no identifier)* R2 V-08 | R2 | **FAIL** | identical to V-06 without an identifier |
| `sr_r2_p01_labeled_text` | R2 | **PASS** | normal announced text |
| `sr_r2_p02_welcome_text` | R2 | **PASS** | same copy as the reference app's "Should Pass" card |
| `sr_r4_v01_generic_button` | R4 Meaningless Spoken Output | **FAIL** (serious) | label "button" flagged |
| `sr_r4_v02_generic_icon` | R4 | **FAIL** | label "icon" flagged |
| `sr_r4_p01_descriptive` | R4 | **PASS** | "Submit order" not flagged |
| `sr_r5_v01_generic_image` | R5 Image Missing Spoken Output | **FAIL** (serious) | image label "image" flagged |
| `sr_r5_v02_empty_logo` | R5 | **FAIL** | empty-label image flagged |
| `sr_r5_p01_described` | R5 | **PASS** | "Nike logo" not flagged |
| `sr_r6_v01_toggle_on` | R6 Duplicate State Info | **FAIL** (moderate) | "on" flagged **because element is a switch** |
| `sr_r6_v02_selected` | R6 | **FAIL** | "Selected" flagged; `expectedOutput` = "Color: Blue, button, selected" style |
| `sr_r6_p01_sony` | R6 | **PASS** | "Sony"/"headphones" must NOT match "on" (word boundary) |
| `sr_r6_p02_shipping` | R6 | **PASS** | "on" on **non-toggle** text must NOT fire |
| `sr_r7_v01_button_word` | R7 Duplicate Type Info | **FAIL** (moderate) | "Button" flagged; `expectedOutput` = "Add to Cart, button" |
| `sr_r7_v02_link_word` | R7 | **FAIL** | "link" flagged |
| `sr_r7_p01_onboarding` | R7 | **PASS** | "Onboarding" must NOT match "on"/type words |
| `sr_r7_p02_clean` | R7 | **PASS** | "Add to Cart" clean |
| `sr_r8_v01_buy_now` | R8 Visible Label Mismatch | **FAIL** (serious) | OCR "Buy Now" ∉ spoken "Complete purchase…" |
| `sr_r8_v02_next` | R8 | **FAIL** | OCR "Next" ∉ "Continue" |
| `sr_r8_p01_send` | R8 | **PASS** | OCR "Send" ⊂ "Send message" |
| `sr_r8_p02_save` | R8 | **PASS** | visible == label → skipped |

### 1a. Cases REMOVED from the fixture (2026-08-17) — unsatisfiable as the rules stand

#### R1 — Interactive Focus Order

R1 fires only on `label == "" && spokenOutput == ""`, and `spokenOutput` is built as
`label + value + trait`. UIKit/SwiftUI always attach a trait to Button/Toggle/Slider/Stepper/Link
(and a value to Toggle/Slider), so `spokenOutput` is never empty for those classes. A developer
**cannot strip an Apple-assigned trait**, so no app code can satisfy the condition — these cards
could never fail and were removed from `ScreenReaderTestView.swift` rather than sit in the fixture
as permanently-green noise.

Evidence (scan `Linear Nav Test1.json`, 19 screens / 67 findings): `sr_r6_v01_toggle_on` captured as
`traits="button"`, `spokenOutput="Wi-Fi on, 1, button"`; every button record shows
`spokenOutput="<label>, button"`. `sr_r1_v01_button` appears in **zero** findings — no rule catches an
unlabeled button, since R4 tests whether the *label* is the word "button", not whether it is empty.

**Restore these verbatim once the engine keys off the accessible NAME (`label` → `value` →
`placeholderValue`) instead of `spokenOutput`** — at that point each should FAIL, and P-01/P-03
become meaningful passes.

```swift
// R1 V-01: Button (XCUIElementTypeButton), empty label — sr_r1_v01_button
Button(action: {}) {
    Image(systemName: "cart").font(.title3).accessibilityHidden(true).padding(.horizontal, 8)
}
.buttonStyle(.borderedProminent)
.accessibilityLabel("")

// R1 V-04: Switch (XCUIElementTypeSwitch), empty label — sr_r1_v04_switch
Toggle("", isOn: $toggleB).labelsHidden().accessibilityLabel("")

// R1 V-05: Slider (adjustable trait), empty label — sr_r1_v05_slider
// NOTE: no XCUIElementTypeSlider appeared anywhere in the scan — possible SECOND defect
// (traversal-capture gap), independent of the spokenOutput bug. Re-check on restore.
Slider(value: $sliderVal, in: 0...100).accessibilityLabel("")

// R1 V-06: Stepper (adjustable trait), empty label — sr_r1_v06_stepper
Stepper("", value: $stepperVal, in: 0...10).labelsHidden().accessibilityLabel("")

// R1 V-07: Link (link trait), empty label — sr_r1_v07_link
Link(destination: URL(string: "https://example.com")!) {
    Image(systemName: "safari").font(.title3).accessibilityHidden(true)
}
.accessibilityLabel("")

// R1 P-01: Button WITH a label (pass) — sr_r1_p01_button_labeled
Button(action: {}) {
    Image(systemName: "cart").font(.title3).accessibilityHidden(true).padding(.horizontal, 8)
}
.buttonStyle(.borderedProminent)
.accessibilityLabel("Cart")

// R1 P-03: Switch WITH a label (pass) — sr_r1_p03_switch_labeled
Toggle("", isOn: $toggleA).labelsHidden().accessibilityLabel("Wi-Fi")

// State vars these need back on ScreenReaderTestView:
//   @State private var sliderVal = 50.0
//   @State private var stepperVal = 3.0
```

Optional diagnostic (not a realistic app pattern — purely to isolate the blocker for the dev):
a `Button` with `.accessibilityRemoveTraits(.isButton)` and an empty label keeps
`class = XCUIElementTypeButton` but empties `traits`. If that fires R1, the trait concatenation into
`spokenOutput` is proven to be the sole cause.

#### R2 — Non-Interactive Focus Order

**Same root cause, and it bites harder here.** Non-interactive classes carry traits too, so their
`spokenOutput` is never empty either. Scan evidence (`Linear Nav Test1.json`):

| Class | `traits` | `spokenOutput` with an EMPTY label | Can R2 fire? |
|---|---|---|---|
| `XCUIElementTypeStaticText` | `staticText` | `", staticText"` | **No** |
| `XCUIElementTypeImage` | `image` | `"image"` | **No** |

Confirmed by absence: **"Screen Reader Focus Missing for Non-Interactive Element" does not appear
anywhere in the scan** — it is not in the rule-name list across 19 screens / 67 findings, while the
other six rules all fired. Every real StaticText and Image is immune by construction.

Removed:

```swift
// R2 V-01: Static text, label blanked — sr_r2_v01_empty_text
// Captured as StaticText → traits="staticText" → spokenOutput=", staticText" → unsatisfiable.
Text("Important notice")
    .accessibilityLabel("")

// R2 V-04: Image, empty label — sr_r2_v04_empty_image
// Captured as Image → traits="image" → spokenOutput="image" → unsatisfiable for R2.
// Redundant anyway: this is an R5 case and R5 already catches it (sr_r5_v02_empty_logo,
// "Image Missing Meaningful Spoken Output", confirmed firing on label="").
Image("wooden_dice").resizable().scaledToFit().frame(height: 44)
    .accessibilityLabel("")
```

**Still open (kept in the fixture — do NOT remove until a scan settles them):** V-02/V-03 and the
dev-app constructions V-05..V-08 all use `.accessibilityElement(children: .ignore)`, which may
collapse the element to `XCUIElementTypeOther` with an EMPTY `traits` string. If so, `spokenOutput`
really is `""` and R2 can fire — which would explain why the reference app fires R2 and we do not.
**Action on the next scan: record `class` and `traits` for each of V-02, V-03, V-05..V-08.** That
single data point decides whether R2 is merely hard to trigger or, like R1, unreachable in real apps.

If `traits` comes back empty for those and they still do not fire, R2 is dead for every element type
and the rule as written cannot detect anything at all.

---

## 2. OCR stress (multilingual) — `sr_ocr01..03`

| Case | Script | Expected |
|---|---|---|
| `sr_ocr01_arabic` | Arabic (RTL) | R2/R5 FAIL; verify OCR reads RTL text into `visibleText`/`expectedOutput` correctly, bounds correct |
| `sr_ocr02_hindi` | Devanagari | R2/R5 FAIL; Devanagari OCR + bounds |
| `sr_ocr03_cjk` | Chinese | R2/R5 FAIL; CJK OCR + bounds |

**Checks:** (a) Vision OCR populates non-empty `visibleText` for each; (b) OCR region correctly matched to the element frame (not a neighbor); (c) no crash/timeout on non-Latin scripts; (d) `expectedOutput` legible. **Known risk:** Vision OCR accuracy varies by script — record actual vs. expected, flag misreads as engine limitations, not test failures.

---

## 3. Linear-navigation mode — `ScreenReaderLinearNavView`

Run with `linearNavigation: true`. Expected: the scan scrolls the **whole** page and finds off-screen violations that auto-report alone would miss.

| Element | Position | Expected |
|---|---|---|
| `sr_lin_top_r1` | top (visible) | R1 FAIL — found in both modes |
| `sr_lin_carousel_r5` | Card 8, **off-screen in horizontal carousel** | R5 FAIL — only found if horizontal scroll works |
| `sr_lin_bottom_r7` | far below fold | R7 FAIL — only found via vertical scroll |
| `sr_lin_bottom_r8` | far below fold | R8 FAIL — only found via vertical scroll |
| `sr_lin_filler_1..18` | between | should be captured (passes), no dupes |

**Mechanics to verify (highest-risk area per RFC):**
- **Vertical exhaustion:** does the >20pt-shift check correctly detect "reached bottom" (not stop early on elastic bounce, not loop forever)?
- **Horizontal carousels:** is the carousel detected (X+Width > viewport), Y-grouped correctly, and swiped left through all 10 cards to reveal Card 8?
- **Dynamic timeout split** `total/(containers×2)`: with 1 vertical + 1 horizontal = 2 containers, confirm per-container time is enough to exhaust; then artificially add carousels and confirm it still finishes within cap (7 min / 420s).
- **Restoration:** `scrollToTop` returns to top after each phase; subsequent customer commands not broken.
- **Dedup:** overlapping scroll captures of `sr_lin_filler_*` collapse via `dedupId` in the "all issues" summary but remain per-scan in traversal view.
- **Customer scroll skip:** in linear mode, a customer `driver.swipe()` is NOT separately scanned.

---

## 4. pHash screen-change detection

| Screen | Path | Expected | Risk being tested |
|---|---|---|---|
| Similar-but-different | `sr_phash_similar_link` → toggle `sr_phash_toggle_error` | after toggle, the NEW `sr_phash_error_label` **is scanned** | **False-skip**: error appears but screen looks ~95% same |
| Animated | `sr_phash_animated_link` | screen scanned **once**, not repeatedly | **False-scan**: a large share of pixels changes every frame |

**Animated-screen elements (strengthened 2026-08-17).** The old fixture was a single 60pt spinner,
which an 8x8 average hash barely notices — a radially-symmetric glyph rotating inside one or two of
the 64 cells is close to a no-op, so it could never approach the >95% skip threshold. The screen now
carries three graded stressors plus a dedup probe:

| Element | Animation | Hash impact | What it proves |
|---|---|---|---|
| `sr_phash_anim_sweep` | wide dark band translating across the full width, 150pt tall | **High** — whole columns of the grid change as it travels | threshold behaviour under large-block luminance movement |
| `sr_phash_anim_tiles` | 4x3 checkerboard inverting light↔dark | **Maximal** — flips many of the 64 cells at once | the adversarial worst case for average-hash |
| `sr_phash_spinner` | same spinner, now 120pt | **Low** — symmetric rotation | control: size alone should not move the hash |
| `sr_phash_anim_r7_button` | none (static) | — | **dedup probe**, see below |

**Dedup probe.** `sr_phash_anim_r7_button` is a stable R7 violation (label "Submit Button" repeats
the element type) sitting on the animated screen. R7 is confirmed-firing, so it will be reported. In
linear mode `dedupId = SHA256(element_id + "_" + ruleID)`, so it must appear **exactly once** in the
report — a second occurrence means a re-scan slipped past dedup, which is the actual user-visible
damage of a false-scan (duplicate issues + burned linear-navigation timeout budget).

Record for each run: how many scans this screen produced, and whether the accessibility content
(which never changes) was re-reported. If the sweep/tiles do force re-scans while the spinner does
not, that quantifies where the 95% threshold actually sits.

**Checks:**
- Navigating **back** to an already-scanned screen does **not** re-scan (hash match).
- First screen (home) always scanned (baseline).
- Status-bar changes (clock, notch/Dynamic Island) do **not** trigger re-scan (top-5% crop).
- Meaningful change under a fixed header (list content swap) **does** trigger a scan — build/borrow a case if the fixture's error-toggle isn't sensitive enough; tune the 95% threshold observation.

---

## 5. Capability / gating / mode tests

| # | Scenario | Expected |
|---|---|---|
| G1 | `accessibility: true` **only** (no screen-reader caps) | **No** screen-reader init, zero overhead, existing a11y scan unchanged (Success Metric #5) |
| G2 | `screenReaderAutomation.autoReport: true` | report generated, one snapshot per trigger command |
| G3 | `screenReaderAutomation.linearNavigation: true` | full scroll-through scan |
| G4 | both true | verify precedence/behavior per RFC (linear blocks response) |
| G5 | caps on **Android** session | rejected/ignored (iOS-only validated in HPS) — no crash |
| G6 | `linearNavigationTimeout` = 0 or > 420s | capped to 7 min |
| G7 | `linearNavigationTimeout` < 420s | honored as-is |
| G8 | trigger-command config via Amplitude `ScreenReaderTriggerCommands` | only listed commands trigger capture |

---

## 6. Kill-switch / config

| # | Scenario | Expected |
|---|---|---|
| K1 | Amplitude `screen_reader_rules_exclusion` = `{"disabled":["DuplicateTypeInfo"]}` | R7 produces **no violations and no passes**; other rules unaffected |
| K2 | exclude multiple rules | all listed rules silent |
| K3 | malformed flag payload | graceful — scan still runs, no crash |
| K4 | remove screenReader caps entirely | zero init/overhead |

---

## 7. Known-ambiguity checks (spec risks — verify explicitly, these may be RFC bugs)

These are places where the RFC's detection logic may diverge from real behavior. **Each is a potential defect to confirm with the dev (@saksharora), not just a test:**

1. **R1 `spokenOutput == ""` may never be true for controls with traits.** The RFC computes `spokenOutput = [label, value, traits].join(", ")`; a button always has a `button` trait → `spokenOutput = "button"` ≠ `""`, so `sr_r1_v01/v02` might **not** fire even though they should. **Verify the empty-name buttons are actually flagged.** If not → detection-logic bug.
2. **Traversal heuristic** (`isLeaf || hasLabel || hasIdentifier`, used because `isAccessibilityElement` isn't populated). Check for (a) elements VoiceOver focuses but the scan **misses** (combined/grouped containers), and (b) decorative leaves the scan **over-captures**. Compare scan `traversalOrder` count/order vs. an actual VoiceOver swipe-through.
3. **Traversal order vs. visual order** — does `traversalIndex` match the real VoiceOver order (top-left → bottom-right), including the multi-element cards here?
4. **Bounds scaling** — `boundsInScreen` = points × `UIScreen.scale`. Verify on a **3x** device (Pro/Max) and a **2x** device that the overlay box lands exactly on the element in the screenshot at the stated `image_resolution`.
5. **R8 OCR dependency** — SwiftUI buttons may not populate `snap.title`; confirm OCR fallback fires and matches the right region (not an adjacent card's text) for `sr_r8_*`.
6. **Word-boundary matching** — confirm the adversarial passes (`sr_r6_p01_sony`, `sr_r6_p02_shipping`, `sr_r7_p01_onboarding`) do **not** fire, and add more (proper nouns containing "on"/"off"/type words).

---

## 8. Cross-platform / parity notes

- **No executor/assertion API** in this feature (BrowserStack has `screenReaderAction`/`screenReaderSpokenDescription`). Confirm this is intentional v1 scope — if a user expects to *script* VoiceOver gestures and assert spoken output in their test, that is **not** supported here.
- **Reading Order (Rule 3)** is out of this report — covered by the existing AI `TraversalOrderMismatch` rule. Verify a reading-order violation still surfaces via that path, and that testers/PMs know it won't appear in the screen-reader report.
- **`autoReport` billing** — RFC open item: does an auto-report scan count as a billable accessibility scan? Confirm before GA.

---

## 9. Regression / non-functional

- Existing iOS a11y scans unchanged (G1).
- Session stability: no added flakiness from the proxy hook blocking responses (linear mode).
- Performance: capture the added latency per trigger command (screenshot ~1s + agent/OCR); confirm within acceptable test-duration budget.
- Report delivery: Kafka → LAS (`test`/`test_details`) and OpenSearch (`allIssues`+`passes`) both populated; `IssueCount` includes `needs_review`.

---

## 10. Exit criteria

- All §1 cases return the expected verdict with correct `spokenOutput`/`expectedOutput`/bounds.
- §3 linear nav finds all off-screen violations within the timeout, restores position, no infinite loop.
- §4 pHash: no false-skips on meaningful change, no runaway re-scans on animation.
- §5 gating: **zero** impact on non-screen-reader tests proven.
- §7 ambiguities each resolved (confirmed working or logged as defects).
