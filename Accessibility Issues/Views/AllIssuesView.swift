import SwiftUI

struct AllIssuesView: View {
    @State private var isToggled = false
    @State private var switchWithoutTraits = false
    @State private var switchWithTraits = false
    @State private var textInput = ""
    @State private var buttonAction1 = false
    @State private var buttonAction2 = false
    @State private var buttonAction3 = false
    @State private var notificationsOn = true
    @State private var darkModeOff = false
    @State private var soundToggle = true

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 25, pinnedViews: [.sectionHeaders]) {
                // Labels & Descriptions Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Checkbox without label", wcagRef: "1.3.1, 4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Checkboxes must have clear labels indicating what option they control.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 20) {
                                    CustomCheckboxNoLabel(isChecked: $isToggled)
                                    CustomCheckbox(isChecked: $isToggled, label: "Checkbox")
                                        .accessibilityLabel("")
                                    CustomCheckbox(isChecked: $isToggled, label: "1")
                                }
                            }
                        }
                        
                        IssueSection(title: "Custom switch missing role/traits", wcagRef: "1.3.1, 4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Custom controls that look like switches must declare their role using accessibility traits so screen readers understand their purpose and state.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    // Custom switch WITHOUT accessibility traits (accessibility issue)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Switch without role/traits:")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                        HStack {
                                            Text("Enable dark mode")
                                            Spacer()
                                            CustomSwitchNoTraits(isOn: $switchWithoutTraits)
                                        }
                                        Text("Screen readers won't understand this is a switch")
                                            .font(.caption2)
                                            .foregroundColor(.red.opacity(0.8))
                                    }
                                    
                                    Divider()
                                    
                                    // Custom switch WITH proper accessibility traits (correct implementation)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Switch with proper role/traits:")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                        HStack {
                                            Text("Enable notifications")
                                            Spacer()
                                            CustomSwitchWithTraits(isOn: $switchWithTraits, label: "Enable notifications")
                                        }
                                        Text("Properly exposes role, state, and label")
                                            .font(.caption2)
                                            .foregroundColor(.green.opacity(0.8))
                                    }
                                }
                            }
                        }
                        
                        IssueSection(title: "Button missing interactive trait", wcagRef: "1.3.1, 4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Elements that look like buttons but don't have proper accessibility traits. VoiceOver announces only the text without indicating it's interactive or that it has a button role.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    // Button WITHOUT accessibility traits (accessibility issue)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Button without traits:")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                        CustomButtonNoTraits(title: "Update Profile", actionPerformed: $buttonAction1)
                                        if buttonAction1 {
                                            Text("✓ Profile Updated!")
                                                .foregroundColor(.green)
                                                .font(.caption)
                                                .transition(.scale)
                                        }
                                        Text("Looks like a button but VoiceOver doesn't announce button role")
                                            .font(.caption2)
                                            .foregroundColor(.red.opacity(0.8))
                                    }
                                    
                                    Divider()
                                    
                                    // Button WITH proper accessibility traits (correct implementation)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Button with proper traits:")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                        CustomButtonWithTraits(title: "Update Profile", actionPerformed: $buttonAction2)
                                        if buttonAction2 {
                                            Text("✓ Profile Updated!")
                                                .foregroundColor(.green)
                                                .font(.caption)
                                                .transition(.scale)
                                        }
                                        Text("Properly announces as a button with role")
                                            .font(.caption2)
                                            .foregroundColor(.green.opacity(0.8))
                                    }
                                    
                                    Divider()
                                    
                                    // Native Button (always correct)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Native Button (always correct):")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                        NativeButton(title: "Update Profile", actionPerformed: $buttonAction3)
                                        if buttonAction3 {
                                            Text("✓ Profile Updated!")
                                                .foregroundColor(.green)
                                                .font(.caption)
                                                .transition(.scale)
                                        }
                                        Text("Native Button automatically has proper traits")
                                            .font(.caption2)
                                            .foregroundColor(.green.opacity(0.8))
                                    }
                                }
                            }
                        }
                        
                        IssueSection(title: "Editable field missing description", wcagRef: "1.3.1, 4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Text fields must have placeholders or labels explaining what input is expected.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                TextField("", text: $textInput)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        IssueSection(title: "Duplicate accessibility labels", wcagRef: "4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Multiple elements with identical labels confuse screen reader users about which element they're interacting with.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 15) {
                                    Button("Settings") {}
                                        .accessibilityLabel("Open Settings")
                                    Button("Preferences") {}
                                        .accessibilityLabel("Open Settings")
                                }
                            }
                        }
                        
                        IssueSection(title: "Images with missing or incorrect labels", wcagRef: "1.1.1") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Images need accurate alternative text describing their content and purpose.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(spacing: 16) {
                                    Image("cat")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height: 200)
                                        .clipped()
                                        .accessibilityLabel("")

                                    Image("cat")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height: 200)
                                        .clipped()
                                        .accessibilityLabel("A cute brown dog playing with a ball")

                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                        .accessibilityLabel("")
                                }
                            }
                        }
                        
                        IssueSection(title: "Button label issues", wcagRef: "1.3.1, 2.4.6, 4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Buttons need clear, descriptive labels that convey their action without visual context.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(spacing: 12) {
                                    Button(action: {}) {
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: 44, height: 44)
                                    }
                                    Button("") {}
                                        .frame(width: 44, height: 44)
                                        .background(Color.blue)
                                    Button("...") {}
                                        .frame(width: 44, height: 44)
                                        .background(Color.blue)
                                }
                            }
                        }
                        
                        IssueSection(title: "Punctuated accessibility label", wcagRef: "3.1.1") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Accessibility labels shouldn't end with punctuation as screen readers add their own pauses.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Button("Submit") {}
                                    .accessibilityLabel("Submit.")
                            }
                        }
                        
                        IssueSection(title: "Label mismatch", wcagRef: "2.5.3") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Accessibility labels must match visible text to avoid confusion.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Button("Sign Up") {}
                                    .accessibilityLabel("Register")
                            }
                        }
                        
                        IssueSection(title: "Vague link text", wcagRef: "2.4.4") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Links should have descriptive text indicating their destination, not generic phrases.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Link("Click here", destination: URL(string: "https://example.com")!)
                            }
                        }

                        IssueSection(title: "Different visible text and accessibility label", wcagRef: "Best Practice") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Sometimes you want different visible text and accessibility label for better UX.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(alignment: .leading, spacing: 12) {
                                    // Example 1: Abbreviated text with full description for accessibility
                                    Button(action: {}) {
                                        Text("FAQ")
                                            .font(.headline)
                                    }
                                    .accessibilityLabel("Frequently Asked Questions - Get help and answers to common questions")

                                    // Example 2: Icon with descriptive label
                                    Button(action: {}) {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                    }
                                    .accessibilityLabel("Add to favorites")

                                    // Example 3: Technical term with explanation
                                    Button(action: {}) {
                                        Text("API Docs")
                                    }
                                    .accessibilityLabel("Application Programming Interface Documentation")

                                    // Example 4: Special character in accessibility label
                                    Button(action: {}) {
                                        Text("Add to Favorites")
                                            .font(.headline)
                                    }
                                    .accessibilityLabel("Add to favorites ❤️ - save this item for later")

                                    // Example 5: Link with different visible text and accessibility label
                                    Link("click here", destination: URL(string: "https://developer.apple.com/accessibility")!)
                                        .accessibilityLabel("Learn more about iOS accessibility guidelines and best practices")

                                    // Multiple buttons with same "click here" text to test specific element targeting
                                    Button("click here") {
                                        print("First button clicked")
                                    }
                                    .accessibilityLabel("Download user guide - get detailed instructions")
                                    .padding(.vertical, 4)

                                    Button("click here") {
                                        print("Second button clicked")
                                    }
                                    .accessibilityLabel("Contact support - get help from our team")
                                    .padding(.vertical, 4)

                                    Button("click here") {
                                        print("Third button clicked")
                                    }
                                    .accessibilityLabel("View privacy policy - learn how we protect your data")
                                    .padding(.vertical, 4)

                                    Text("Multiple elements with same visible text test specific element identification.")
                                        .font(.caption2)
                                        .foregroundColor(.orange.opacity(0.8))
                                        .padding(.top, 8)

                                    Text("These examples show appropriate use of different visible text and accessibility labels, including emojis and links.")
                                        .font(.caption2)
                                        .foregroundColor(.green.opacity(0.8))
                                }
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Labels & Descriptions", color: .blue)
                }

                // Accessibility Label Violations Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Duplicate state info in accessibility labels", wcagRef: "4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Accessibility labels should not include redundant state information that screen readers automatically announce.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(alignment: .leading, spacing: 12) {
                                    Toggle(isOn: $notificationsOn) {
                                        Text("Notifications")
                                    }
                                    .accessibilityLabel("Notifications ON") // Violation: includes state "ON"

                                    Toggle(isOn: $darkModeOff) {
                                        Text("Dark Mode")
                                    }
                                    .accessibilityLabel("Dark Mode OFF") // Violation: includes state "OFF"

                                    Text("Screen readers automatically announce toggle states. Including state info in labels creates redundancy.")
                                        .font(.caption2)
                                        .foregroundColor(.red.opacity(0.8))
                                }
                            }
                        }

                        IssueSection(title: "Duplicate type info in accessibility labels", wcagRef: "4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Accessibility labels should not include control type information that screen readers automatically announce.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(alignment: .leading, spacing: 12) {
                                    Button(action: {}) {
                                        Text("Save")
                                    }
                                    .accessibilityLabel("Save Button") // Violation: includes type "Button"

                                    Toggle(isOn: $soundToggle) {
                                        Text("Sound")
                                    }
                                    .accessibilityLabel("Sound Toggle Switch") // Violation: includes type "Toggle Switch"

                                    Link("Learn More", destination: URL(string: "https://example.com")!)
                                        .accessibilityLabel("Learn More Link") // Violation: includes type "Link"

                                    Text("Screen readers automatically announce control types. Including type info in labels creates redundancy.")
                                        .font(.caption2)
                                        .foregroundColor(.red.opacity(0.8))
                                }
                            }
                        }

                        IssueSection(title: "Label in name violation", wcagRef: "2.5.3") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: The accessibility label must contain the visible text. Voice control users speak the visible text to activate controls, so the accessible name must include it.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(alignment: .leading, spacing: 12) {
                                    // Violation: Visible text "Submit" but label is "Send Form"
                                    Button(action: {}) {
                                        Text("Submit")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Send Form")

                                    Text("❌ Violation: Button shows 'Submit' but label is 'Send Form'")
                                        .font(.caption2)
                                        .foregroundColor(.red.opacity(0.8))

                                    // Violation: Visible text "Sign Up" but label is "Register"
                                    Button(action: {}) {
                                        Text("Sign Up")
                                            .padding()
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Register")

                                    Text("❌ Violation: Button shows 'Sign Up' but label is 'Register'")
                                        .font(.caption2)
                                        .foregroundColor(.red.opacity(0.8))

                                    Divider()

                                    // Correct: Visible text matches label
                                    Button(action: {}) {
                                        Text("Submit")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Submit Form")

                                    Text("✅ Correct: Label 'Submit Form' contains visible text 'Submit'")
                                        .font(.caption2)
                                        .foregroundColor(.green.opacity(0.8))

                                    Text("Voice control users say the visible text to activate controls. If the label doesn't contain the visible text, voice commands won't work.")
                                        .font(.caption2)
                                        .foregroundColor(.orange.opacity(0.8))
                                        .padding(.top, 8)
                                }
                            }
                        }

                        IssueSection(title: "Label at front violation", wcagRef: "2.5.3") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: The accessibility label should start with the visible text. This best practice ensures voice control recognition works optimally and provides consistent user experience.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(alignment: .leading, spacing: 12) {
                                    // Violation: Visible text "Submit" but label starts with "Click to"
                                    Button(action: {}) {
                                        Text("Submit")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Click to Submit Form")

                                    Text("⚠️ Violation: Label starts with 'Click to' instead of 'Submit'")
                                        .font(.caption2)
                                        .foregroundColor(.red.opacity(0.8))

                                    // Violation: Visible text "Delete" but label starts with "Tap here to"
                                    Button(action: {}) {
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("Delete")
                                        }
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Tap here to Delete item")

                                    Text("⚠️ Violation: Label starts with 'Tap here to' instead of 'Delete'")
                                        .font(.caption2)
                                        .foregroundColor(.red.opacity(0.8))

                                    Divider()

                                    // Correct: Label starts with visible text
                                    Button(action: {}) {
                                        Text("Submit")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Submit Form")

                                    Text("✅ Correct: Label starts with visible text 'Submit'")
                                        .font(.caption2)
                                        .foregroundColor(.green.opacity(0.8))

                                    // Correct: Label starts with visible text
                                    Button(action: {}) {
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("Delete")
                                        }
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                    }
                                    .accessibilityLabel("Delete item from list")

                                    Text("✅ Correct: Label starts with visible text 'Delete'")
                                        .font(.caption2)
                                        .foregroundColor(.green.opacity(0.8))

                                    Text("Starting labels with visible text improves voice control accuracy and provides better predictability for screen reader users.")
                                        .font(.caption2)
                                        .foregroundColor(.orange.opacity(0.8))
                                        .padding(.top, 8)
                                }
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Accessibility Label Violations", color: .purple)
                }

                // Contrast & Color Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Low text contrast", wcagRef: "1.4.3") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Text must have sufficient contrast ratio (4.5:1 for normal text, 3:1 for large text) against its background.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("This text has low contrast")
                                    .foregroundColor(Color(hex: "CCCCCC"))
                            }
                        }
                        
                        IssueSection(title: "Low non-text contrast", wcagRef: "1.4.11") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: UI components and graphical objects need 3:1 contrast ratio to be perceivable.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Rectangle()
                                    .fill(Color(hex: "E0E0E0"))
                                    .frame(height: 2)
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Contrast & Color", color: .purple)
                }
                
                // Navigation & Focus Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Missing semantic info", wcagRef: "1.3.3, 4.1.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Custom interactive elements must properly declare their role (button, link, etc.) using accessibility traits.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 44)
                                    .overlay(
                                        Text("Clickable Area")
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        
                        IssueSection(title: "Illogical focus order", wcagRef: "2.4.3") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Interactive elements should receive focus in a logical, predictable order that matches visual layout.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                VStack(spacing: 10) {
                                    TextField("First field", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Second field", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Third field", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Navigation & Focus", color: .green)
                }
                
                // Layout & Structure Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Orientation issues", wcagRef: "1.3.4") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Content should adapt to both portrait and landscape orientations without loss of information or functionality.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack {
                                    ForEach(1...5, id: \.self) { _ in
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: 60, height: 60)
                                    }
                                }
                            }
                        }
                        
                        IssueSection(title: "Non-responsive container", wcagRef: "1.4.10") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Content should reflow to avoid horizontal scrolling at standard zoom levels (up to 200%).")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(1...5, id: \.self) { _ in
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(width: 200, height: 100)
                                        }
                                    }
                                }
                            }
                        }
                        
                        IssueSection(title: "Two-way scrolling", wcagRef: "1.4.10") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Content requiring both horizontal and vertical scrolling creates navigation difficulties.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
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
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Layout & Structure", color: .orange)
                }
                
                // Input & Forms Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Form field without label", wcagRef: "1.3.5, 2.4.6, 3.3.2") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Form inputs need labels that clearly identify what information is required.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                TextField("", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        IssueSection(title: "Wrong input type", wcagRef: "1.3.5") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Input fields should use appropriate keyboard types (number pad for phone, email keyboard for email) to aid data entry.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                TextField("Phone", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Input & Forms", color: .red)
                }
                
                // Text & Typography Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Non-scalable text", wcagRef: "1.4.4") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Text should use dynamic type and scale with user's font size preferences, not fixed pixel sizes.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Fixed size text")
                                    .font(.system(size: 14))
                            }
                        }
                        
                        IssueSection(title: "Truncated text", wcagRef: "1.4.4") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Text content should not be truncated without providing access to the full text.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("This is a very long text that will be truncated because it doesn't fit in the container and there's no way to read the full content")
                                    .lineLimit(1)
                            }
                        }
                        
                        IssueSection(title: "Cramped text spacing", wcagRef: "1.4.12") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Text must have adequate line height and spacing to remain readable when users adjust spacing settings.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("This text has minimal line height and letter spacing making it difficult to read")
                                    .lineSpacing(0.5)
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Text & Typography", color: .indigo)
                }
                
                // Interaction & Touch Section
                Section {
                    VStack(spacing: 20) {
                        IssueSection(title: "Small touch targets", wcagRef: "2.5.5") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Touch targets must be at least 44x44 points to be easily tappable, especially for users with motor impairments.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Button("×") {}
                                    .frame(width: 20, height: 20)
                            }
                        }
                        
                        IssueSection(title: "Cramped touch targets", wcagRef: "2.5.8") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description: Interactive elements need adequate spacing between them to prevent accidental activation.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 5) {
                                    ForEach(1...5, id: \.self) { _ in
                                        Button("Option") {}
                                            .frame(width: 60, height: 30)
                                    }
                                }
                            }
                        }
                    }
                } header: {
                    SectionHeader(title: "Interaction & Touch", color: .pink)
                }
            }
            .padding()
        }
        .navigationTitle("")
    }
}

#Preview {
    NavigationView {
        AllIssuesView()
    }
}
