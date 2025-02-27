//
//  ContentView.swift
//  TaskManager
//
//  Created by PujaRaj on 25/02/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

        @FetchRequest(
            entity: Task.entity() ,
            sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)],
            predicate: nil , animation: .default)
         private var tasks: FetchedResults<Task>
 
        @State private var selectedFilter: TaskFilter = .all
        @State private var showingAddTask = false
    
        private var filteredTasks: [Task] {
        switch selectedFilter {
        case .all:
            return Array(tasks)
        case .completed:
            return tasks.filter { $0.isCompleted }
        case .pending:
            return tasks.filter { !$0.isCompleted }
         }
       }
        
        var body: some View {
            NavigationStack {
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(TaskFilter.allCases, id: \.self) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .accessibilityIdentifier("FilterSegmentedControl")
                .padding()
                List {
                    ForEach(filteredTasks) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            TaskRow(task: task)
                        }
                    }
                    .onDelete(perform: deleteTasks)
                    .onMove(perform: moveTasks)
                }.navigationTitle("Tasks")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddTask.toggle() }) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                }
                .navigationTitle("Tasks")
                .sheet(isPresented: $showingAddTask) {
                    AddTaskView()
                }
            }
        }
        
        private func deleteTasks(offsets: IndexSet) {
            withAnimation {
                offsets.map { tasks[$0] }.forEach(viewContext.delete)
                try? viewContext.save()
            }
        }
        
        private func moveTasks(from source: IndexSet, to destination: Int) {
            // Task reordering logic
        }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


