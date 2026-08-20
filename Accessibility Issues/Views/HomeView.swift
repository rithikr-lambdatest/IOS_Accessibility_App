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
                NavigationLink(destination: AllIssuesView()) {
                    DemoButton(title: "All Issues 1")
                }

                NavigationLink(destination: IssuesByCategoryView()) {
                    DemoButton(title: "All Issues 2")
                }

                NavigationLink(destination: QAIssuesView()) {
                    DemoButton(title: "Accessibility Role Definition")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: SpecialCharacterLabelView()) {
                    DemoButton(title: "Special Character Label")
                }

                NavigationLink(destination: ViewStateLabelView()) {
                    DemoButton(title: "View State Label")
                }

                NavigationLink(destination: ViewTypeLabelView()) {
                    DemoButton(title: "View Type Label")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: InteractiveElementLabelView()) {
                    DemoButton(title: "Interactive Element Label")
                }

                NavigationLink(destination: MissingImageLabelView()) {
                    DemoButton(title: "Missing Image Element Label")
                }

                NavigationLink(destination: MissingButtonLabelView()) {
                    DemoButton(title: "Missing Button Element Label")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: CheckboxElementLabelView()) {
                    DemoButton(title: "Checkbox Element Label")
                }

                NavigationLink(destination: EditableElementLabelView()) {
                    DemoButton(title: "Editable Element Label")
                }

                NavigationLink(destination: ButtonCapitalizationView()) {
                    DemoButton(title: "Button Element Capitalization")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: LabelNotPunctuatedView()) {
                    DemoButton(title: "Label Not Punctuated")
                }

                NavigationLink(destination: DuplicateAccessibilityLabelView()) {
                    DemoButton(title: "Duplicate Accessibility Label")
                }

                NavigationLink(destination: ColorContrastView()) {
                    DemoButton(title: "Color Contrast")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: TextTruncationView()) {
                    DemoButton(title: "Text Truncation")
                }

                NavigationLink(destination: LabelInNameView()) {
                    DemoButton(title: "Label in Name")
                }

                NavigationLink(destination: LabelAtFrontView()) {
                    DemoButton(title: "Label at Front")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: TwoDimensionalScrollingView()) {
                    DemoButton(title: "Two-Dimensional Scrolling")
                }

                NavigationLink(destination: OrientationLockView()) {
                    DemoButton(title: "Orientation Lock")
                }

                NavigationLink(destination: LinkTextPurposeView()) {
                    DemoButton(title: "Link Text Purpose")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: OverlappingElementsView()) {
                    DemoButton(title: "Overlapping Elements")
                }

                NavigationLink(destination: TouchTargetSpacingView()) {
                    DemoButton(title: "Touch Target Spacing")
                }

                NavigationLink(destination: TraversalOrderView()) {
                    DemoButton(title: "Traversal Order")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: ImagesWithTextView()) {
                    DemoButton(title: "Images with Text")
                }

                NavigationLink(destination: MeaningfulReadingOrderView()) {
                    DemoButton(title: "Meaningful Reading Order")
                }

                NavigationLink(destination: MinimumTextSizeView()) {
                    DemoButton(title: "Minimum Text Size")
                }
            }

            HStack(spacing: 10) {
                NavigationLink(destination: InvalidRangeValuesView()) {
                    DemoButton(title: "Invalid Range Values")
                }

                NavigationLink(destination: UniqueOptionNamesView()) {
                    DemoButton(title: "Unique Option Names")
                }

                NavigationLink(destination: ScreenReaderTestView()) {
                    DemoButton(title: "Screen Reader Automation")
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
