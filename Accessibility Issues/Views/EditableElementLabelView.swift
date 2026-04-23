import SwiftUI

struct EditableElementLabelView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Editable Element Accessibility Label")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Ensures all editable elements have descriptive accessibility labels so screen readers can announce their purpose.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        // TC-01: TextField with no label
                        Group {
                            Text("TC-01: TextField with No Label")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text field without any accessibility label")
                                .font(.caption)
                            TextField("Type here", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("")
                                .accessibilityIdentifier("tc01_textfield_no_label")
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Positive Test Cases (VALID)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Positive Test Cases (VALID)")
                            .font(.headline)
                            .foregroundColor(Color(red: 0, green: 0.5, blue: 0))

                        // TC-02: TextField with descriptive label
                        Group {
                            Text("TC-02: TextField with Descriptive Label (PASS)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Text field with clear accessibility label")
                                .font(.caption)
                            TextField("Enter email", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .accessibilityLabel("Email Address")
                                .accessibilityIdentifier("tc02_textfield_with_label")
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.5, blue: 0).opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("")
    }
}

#Preview {
    NavigationView {
        EditableElementLabelView()
    }
}
