import SwiftUI

struct Child: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let grade: String
}

struct ChildSelectionSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedChildId: UUID?
    
    let children = [
        Child(name: "Emma Johnson", age: 8, grade: "3rd Grade"),
        Child(name: "Noah Smith", age: 10, grade: "5th Grade"),
        Child(name: "Olivia Brown", age: 7, grade: "2nd Grade"),
        Child(name: "Liam Davis", age: 9, grade: "4th Grade")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("Select Child")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Choose a child to view their accessibility report")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // Children List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(children) { child in
                            ChildCard(
                                child: child,
                                isSelected: selectedChildId == child.id,
                                onTap: {
                                    selectedChildId = child.id
                                }
                            )
                        }
                    }
                    .padding()
                }
                
                // Bottom buttons
                HStack(spacing: 16) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                    
                    Button("Continue") {
                        // Handle selection and dismiss
                        if selectedChildId != nil {
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedChildId != nil ? Color.blue : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(selectedChildId == nil)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ChildCard: View {
    let child: Child
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Avatar
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 28))
                        .foregroundColor(isSelected ? .white : .gray)
                }
                
                // Child Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(child.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        Label("\(child.age) years", systemImage: "birthday.cake")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Label(child.grade, systemImage: "book")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Selection indicator
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .blue : .gray.opacity(0.3))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: isSelected ? Color.blue.opacity(0.3) : Color.black.opacity(0.1),
                            radius: isSelected ? 8 : 4,
                            x: 0,
                            y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ChildSelectionSheet()
}

