//
//  AddTaskView.swift
//  TaskManager
//
//  Created by PujaRaj on 25/02/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority = "Medium"
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    Picker("Priority", selection: $priority) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") { addTask() }
                }
            }
        }
    }
    
    private func addTask() {
        let newTask = Task(context: viewContext)
        newTask.title = title
        newTask.desc = description
        newTask.dueDate = dueDate
        newTask.priority = priority
        newTask.isCompleted = false
        try? viewContext.save()
        do {
                try viewContext.save()
                print("✅ Task Created: \(newTask.title ?? "Untitled"), Completed: \(newTask.isCompleted)")
            } catch {
                print("❌ Failed to save task: \(error.localizedDescription)")
            }
        dismiss()
    }
}

#Preview {
    AddTaskView()
}
