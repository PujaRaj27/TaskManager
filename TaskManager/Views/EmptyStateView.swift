//
//  EmptyStateView.swift
//  TaskManager
//
//  Created by PujaRaj on 25/02/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
            VStack {
                Image(systemName: "tray.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text("No Tasks Available")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("Tap + to add a new task")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
}

#Preview {
    EmptyStateView()
}
