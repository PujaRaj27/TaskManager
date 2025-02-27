//
//  TaskRow.swift
//  TaskManager
//
//  Created by PujaRaj on 25/02/25.
//

import SwiftUI

struct TaskRow: View {
    var task: Task
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.title ?? "Untitled")
                        .font(.headline)
                        .accessibilityIdentifier("taskTitle")
                    Text(task.dueDate ?? Date(), style: .date)
                        .font(.subheadline)
                }
                Spacer()
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .onAppear {
                        print("Task Loaded: \(task.title ?? "Untitled"), Completed: \(task.isCompleted)")
                    }
        }
}
