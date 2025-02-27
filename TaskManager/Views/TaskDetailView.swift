//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by PujaRaj on 25/02/25.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var task: Task
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                Text(task.title ?? "Untitled")
                    .font(.title2)
                    .bold()
                
                Text(task.desc ?? "No description available")
                    .font(.body)
                    .foregroundColor(.gray)
                
                HStack {
                    Text("Due Date:")
                    Spacer()
                    Text(task.dueDate ?? Date(), style: .date)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Priority:")
                    Spacer()
                    Text(task.priority ?? "Medium")
                        .foregroundColor(priorityColor(task.priority))
                }
            }
            
            Section {
                Button(action: { toggleCompletion() }) {
                    Label(task.isCompleted ? "Mark as Pending" : "Mark as Completed",
                          systemImage: task.isCompleted ? "circle" : "checkmark.circle.fill")
                    .foregroundColor(task.isCompleted ? .gray : .green)
                }
                
                Button(role: .destructive, action: { deleteTask() }) {
                    Label("Delete Task", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Task Details")
    }
    
    private func toggleCompletion() {
        withAnimation {
    task.isCompleted.toggle()
            do {
                    try viewContext.save() // Save changes to Core Data
                } catch {
                    print("Error saving task completion status: \(error.localizedDescription)")
                }
}
    }
    
    private func deleteTask() {
        viewContext.delete(task)
        try? viewContext.save()
        dismiss()
    }
    
    private func priorityColor(_ priority: String?) -> Color {
        switch priority {
        case "High": return .red
        case "Medium": return .orange
        case "Low": return .green
        default: return .gray
        }
    }
}

