import Foundation

struct AccessibilityIssue: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let wcagReference: String
    let category: IssueCategory
    let severity: IssueSeverity
    
    enum IssueCategory: String, CaseIterable {
        case labels = "Labels & Descriptions"
        case contrast = "Contrast & Color"
        case navigation = "Navigation & Focus"
        case layout = "Layout & Structure"
        case input = "Input & Forms"
        case text = "Text & Typography"
        case interaction = "Interaction & Touch"
    }
    
    enum IssueSeverity: String {
        case critical = "Critical"
        case serious = "Serious"
        case moderate = "Moderate"
        case minor = "Minor"
    }
}

// Sample data
extension AccessibilityIssue {
    static let allIssues: [AccessibilityIssue] = [
        // Labels & Descriptions
        AccessibilityIssue(
            title: "Checkbox without label",
            description: "A toggle switch with no accessibility label",
            wcagReference: "1.3.1",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Editable field missing description",
            description: "Text field with no placeholder or label",
            wcagReference: "4.1.2",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Duplicate labels",
            description: "Two buttons with identical accessibility labels",
            wcagReference: "4.1.2",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Editable element without label",
            description: "Text editor with no accessibility label",
            wcagReference: "1.3.1, 4.1.2",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Image without alt text",
            description: "Image with no accessibility label",
            wcagReference: "1.1.1",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Button without meaningful label",
            description: "Button with only 'Click' as label",
            wcagReference: "1.3.1, 2.4.6, 4.1.2",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Complex label structure",
            description: "Label with technical jargon at the beginning",
            wcagReference: "3.1.6",
            category: .labels,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Label mismatch",
            description: "Button visually showing 'Sign Up' but accessibility label is 'Register'",
            wcagReference: "2.5.3",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Vague link text",
            description: "Link labeled just 'Click here'",
            wcagReference: "2.4.4",
            category: .labels,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Special characters in label",
            description: "Button with '###Submit###' as accessibility label",
            wcagReference: "1.3.1",
            category: .labels,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Switch without context",
            description: "Toggle switch with no label indicating what it controls",
            wcagReference: "1.3.1",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "State in label",
            description: "Button with 'Selected Submit Button' mixing state with label",
            wcagReference: "1.3.1",
            category: .labels,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Type in label",
            description: "'Button: Submit' including UI type in accessibility label",
            wcagReference: "1.3.1",
            category: .labels,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Label in name",
            description: "Visible text must be contained in the accessibility label. Speech recognition users say visible labels to activate controls — if the accessible name differs, voice commands fail.",
            wcagReference: "2.5.3",
            category: .labels,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Label at front",
            description: "Visible text should be at the beginning of the accessibility label. Screen readers announce extra text before the expected label, confusing users.",
            wcagReference: "2.5.3",
            category: .labels,
            severity: .serious
        ),
        
        // Contrast & Color
        AccessibilityIssue(
            title: "Low text contrast",
            description: "Light gray text (#CCCCCC) on white background",
            wcagReference: "1.4.3",
            category: .contrast,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Low non-text contrast",
            description: "Light gray border (#E0E0E0) on white background",
            wcagReference: "1.4.3",
            category: .contrast,
            severity: .serious
        ),
        
        // Navigation & Focus
        AccessibilityIssue(
            title: "Missing semantic info",
            description: "Custom clickable view without proper accessibility traits",
            wcagReference: "1.3.3, 4.1.2",
            category: .navigation,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Illogical focus order",
            description: "Elements with incorrect tab order",
            wcagReference: "2.4.3",
            category: .navigation,
            severity: .serious
        ),
        
        // Layout & Structure
        AccessibilityIssue(
            title: "Orientation issues",
            description: "Content that gets cut off in landscape mode",
            wcagReference: "1.3.4",
            category: .layout,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Non-responsive container",
            description: "Fixed-width container causing horizontal scroll",
            wcagReference: "1.4.10",
            category: .layout,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Two-way scrolling",
            description: "Content requiring both horizontal and vertical scroll",
            wcagReference: "1.4.10",
            category: .layout,
            severity: .moderate
        ),
        
        // Input & Forms
        AccessibilityIssue(
            title: "Form field without label",
            description: "Input field with no associated label",
            wcagReference: "1.3.5, 2.4.6, 3.3.2",
            category: .input,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Wrong input type",
            description: "Phone number field using default keyboard instead of number pad",
            wcagReference: "1.3.5",
            category: .input,
            severity: .moderate
        ),
        
        // Text & Typography
        AccessibilityIssue(
            title: "Non-scalable text",
            description: "Text using fixed pixel sizes that don't scale",
            wcagReference: "1.4.4",
            category: .text,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Truncated text",
            description: "Text cut off with '...' without full content access",
            wcagReference: "1.4.4",
            category: .text,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Cramped text spacing",
            description: "Text with minimal line height and letter spacing",
            wcagReference: "1.4.12",
            category: .text,
            severity: .moderate
        ),
        
        // Interaction & Touch
        AccessibilityIssue(
            title: "Small touch targets",
            description: "Buttons smaller than 44x44 points",
            wcagReference: "2.5.5",
            category: .interaction,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Cramped touch targets",
            description: "Multiple small buttons too close together",
            wcagReference: "2.5.8",
            category: .interaction,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Two-dimensional scrolling",
            description: "Content requires both horizontal and vertical scrolling simultaneously. Use single-direction scrolling containers so content is accessible without two-axis scrolling.",
            wcagReference: "1.4.10",
            category: .layout,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "App and screen orientation lock",
            description: "Application locks content to a single orientation (portrait or landscape). Both orientations should be supported unless essential for functionality.",
            wcagReference: "1.3.4",
            category: .layout,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Link text purpose",
            description: "Links must have descriptive text that conveys their purpose. Generic labels like \"click here\" or \"read more\" don't help screen reader users understand the link destination.",
            wcagReference: "2.4.4",
            category: .labels,
            severity: .moderate
        ),
        AccessibilityIssue(
            title: "Overlapping elements",
            description: "Interactive elements must not overlap. Overlapping buttons, links, or inputs cause mis-taps for motor-impaired users and confuse assistive technologies.",
            wcagReference: "2.5.5, 1.3.2",
            category: .interaction,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Touch target spacing",
            description: "Interactive elements must have adequate spacing between them. Insufficient spacing causes accidental activation for users with motor impairments.",
            wcagReference: "2.5.8",
            category: .interaction,
            severity: .serious
        ),
        AccessibilityIssue(
            title: "Traversal order",
            description: "VoiceOver reads elements in DOM order. When DOM order doesn't match visual layout, screen reader users hear content in a confusing, illogical sequence.",
            wcagReference: "2.4.3",
            category: .navigation,
            severity: .serious
        )
    ]
} 
