import SwiftUI

struct IssuesByCategoryView: View {
    @State private var selectedCategory: AccessibilityIssue.IssueCategory = .labels

    var body: some View {
        VStack {
            Picker("Category", selection: $selectedCategory) {
                ForEach(AccessibilityIssue.IssueCategory.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(.menu)
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(filteredIssues) { issue in
                        IssueCard(issue: issue)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("")
    }
    
    private var filteredIssues: [AccessibilityIssue] {
        AccessibilityIssue.allIssues.filter { $0.category == selectedCategory }
    }
}

struct IssueCard: View {
    let issue: AccessibilityIssue
    @State private var switchDemo = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text(issue.title)
                    .font(.headline)
                Spacer()
                Text(issue.severity.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(severityColor)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            // Description
            Text(issue.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // WCAG Reference
            Text("WCAG: \(issue.wcagReference)")
                .font(.caption)
                .foregroundColor(.blue)
            
            // Demo Component
            VStack(alignment: .leading, spacing: 8) {
                Text("Example:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Component demonstration based on issue type
                Group {
                    switch issue.title {
                    case "Checkbox without label", "Switch without context":
                        Toggle("", isOn: $switchDemo)
                            .labelsHidden()
                        
                    case "Editable field missing description", "Form field without label":
                        TextField("", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    case "Duplicate labels":
                        HStack(spacing: 20) {
                            Button("Submit") {}
                            Button("Submit") {}
                        }
                        
                    case "Editable element without label":
                        TextEditor(text: .constant(""))
                            .frame(height: 100)
                            .border(Color.gray, width: 1)
                        
                    case "Image without alt text":
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                    case "Button without meaningful label":
                        Button("Click") {}
                        
                    case "Complex label structure":
                        Text("API endpoint: /v1/users/{id}/profile")
                        
                    case "Label mismatch":
                        Button("Sign Up") {}
                            .accessibilityLabel("Register")
                        
                    case "Vague link text":
                        Link("Click here", destination: URL(string: "https://example.com")!)
                        
                    case "Special characters in label":
                        Button("") {}
                        
                    case "State in label":
                        Button("Selected Submit Button") {}
                        
                    case "Type in label":
                        Button("Button: Submit") {}
                        
                    case "Low text contrast":
                        Text("This text has low contrast")
                            .foregroundColor(Color(hex: "CCCCCC"))
                        
                    case "Low non-text contrast":
                        Rectangle()
                            .fill(Color(hex: "E0E0E0"))
                            .frame(height: 2)
                        
                    case "Missing semantic info":
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 44)
                            .overlay(
                                Text("Clickable Area")
                                    .foregroundColor(.white)
                            )
                        
                    case "Illogical focus order":
                        VStack(spacing: 10) {
                            TextField("First field", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Second field", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Third field", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                    case "Orientation issues":
                        HStack {
                            ForEach(1...5, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 60, height: 60)
                            }
                        }
                        
                    case "Non-responsive container":
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(1...5, id: \.self) { _ in
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 200, height: 100)
                                }
                            }
                        }
                        
                    case "Two-way scrolling":
                        ScrollView([.horizontal, .vertical], showsIndicators: true) {
                            VStack {
                                ForEach(1...3, id: \.self) { _ in
                                    HStack {
                                        ForEach(1...3, id: \.self) { _ in
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(width: 150, height: 150)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                        
                    case "Wrong input type":
                        TextField("Phone", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    case "Non-scalable text":
                        Text("Fixed size text")
                            .font(.system(size: 14))
                        
                    case "Truncated text":
                        Text("This is a very long text that will be truncated because it doesn't fit in the container and there's no way to read the full content")
                            .lineLimit(1)
                        
                    case "Cramped text spacing":
                        Text("This text has minimal line height and letter spacing making it difficult to read")
                            .lineSpacing(0.5)
//                            .tracking(-0.5)
                        
                    case "Small touch targets":
                        Button("X") {}
                            .frame(width: 30, height: 30)
                        
                    case "Cramped touch targets":
                        HStack(spacing: 5) {
                            ForEach(1...5, id: \.self) { _ in
                                Button("Option") {}
                                    .frame(width: 60, height: 30)
                            }
                        }
                        
                    default:
                        EmptyView()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private var severityColor: Color {
        switch issue.severity {
        case .critical:
            return .red
        case .serious:
            return .orange
        case .moderate:
            return .yellow
        case .minor:
            return .green
        }
    }
}

#Preview {
    NavigationView {
        IssuesByCategoryView()
    }
} 
