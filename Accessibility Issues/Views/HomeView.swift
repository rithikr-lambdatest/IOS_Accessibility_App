import SwiftUI

struct HomeView: View {
    @State private var isShowingSheet = false
    @StateObject private var scrollHolder = ScrollArrowHolder()

    var body: some View {
        VStack(spacing: 0) {
        ScrollView {
        VStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.top, 40)
                .padding(.horizontal, 20)
                .accessibilityLabel("TestMu AI Logo")

            HStack(spacing: 10) {
                NavigationLink(destination: InteractiveRoleUndefinedView()) {
                    DemoButton(title: "Interactive Role Undefined")
                }

                NavigationLink(destination: EmojiOrSymbolUsedInAccessibilityLabelView()) {
                    DemoButton(title: "Emoji or Symbol Used in Accessibility Label")
                }

                NavigationLink(destination: RedundantStateKeywordInAccessibilityLabelView()) {
                    DemoButton(title: "Redundant State Keyword in Accessibility Label")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: RedundantRoleKeywordInAccessibilityLabelView()) {
                    DemoButton(title: "Redundant Role Keyword in Accessibility Label")
                }

                NavigationLink(destination: NonAccessibleInteractionView()) {
                    DemoButton(title: "Non-accessible Interaction")
                }

                NavigationLink(destination: MissingImageLabelView()) {
                    DemoButton(title: "Missing Image Element Label")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: MissingButtonLabelView()) {
                    DemoButton(title: "Missing Button Element Label")
                }

                NavigationLink(destination: MissingSwitchElementLabelView()) {
                    DemoButton(title: "Missing Switch Element Label")
                }

                NavigationLink(destination: MissingEditableElementLabelView()) {
                    DemoButton(title: "Missing Editable Element Label")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: ButtonCapitalizationView()) {
                    DemoButton(title: "Button Element Capitalization")
                }

                NavigationLink(destination: LabelNotPunctuatedView()) {
                    DemoButton(title: "Label Not Punctuated")
                }

                NavigationLink(destination: DuplicateAccessibilityLabelView()) {
                    DemoButton(title: "Duplicate Accessibility Label")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: ColorContrastView()) {
                    DemoButton(title: "Color Contrast")
                }

                NavigationLink(destination: TextTruncationView()) {
                    DemoButton(title: "Text Truncation")
                }

                NavigationLink(destination: DynamicTypeSupportView()) {
                    DemoButton(title: "Dynamic Type Support")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: MismatchedLabelTextView()) {
                    DemoButton(title: "Mismatched Label Text")
                }

                NavigationLink(destination: MisplacedFieldLabelView()) {
                    DemoButton(title: "Misplaced Field Label")
                }

                NavigationLink(destination: TwoDimensionalScrollingView()) {
                    DemoButton(title: "Two-Dimensional Scrolling")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: OrientationLockView()) {
                    DemoButton(title: "Orientation Lock")
                }

                NavigationLink(destination: NonDescriptiveLinkTextView()) {
                    DemoButton(title: "Non-Descriptive Link Text")
                }

                NavigationLink(destination: OverlappingElementsView()) {
                    DemoButton(title: "Overlapping Elements")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: InsufficientTouchTargetSpacingView()) {
                    DemoButton(title: "Insufficient Touch Target Spacing")
                }

                NavigationLink(destination: TraversalOrderView()) {
                    DemoButton(title: "Traversal Order")
                }

                NavigationLink(destination: ImagesWithTextView()) {
                    DemoButton(title: "Images with Text")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: MeaningfulSequenceView()) {
                    DemoButton(title: "Meaningful Sequence")
                }

                NavigationLink(destination: MinimumTextSizeView()) {
                    DemoButton(title: "Minimum Text Size")
                }

                NavigationLink(destination: InvalidRangeValuesView()) {
                    DemoButton(title: "Invalid Range Values")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: UniqueOptionNamesView()) {
                    DemoButton(title: "Unique Option Names")
                }

                NavigationLink(destination: ScreenReaderTestView()) {
                    DemoButton(title: "Screen Reader Automation")
                }

                NavigationLink(destination: TouchTargetSizingView()) {
                    DemoButton(title: "Touch Target Sizing")
                }
            }

        }
        .padding()
        .background(ScrollViewFinder(holder: scrollHolder))
        }
        ScrollArrowBar(holder: scrollHolder)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingSheet) {
            ChildSelectionSheet()
                .presentationDetents([.medium, .large])
        }
    }
}

struct DemoButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
} 
