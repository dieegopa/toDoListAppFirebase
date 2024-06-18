//
//  ContentView.swift
//  ToDoList
//
//  Created by Diego Padilla on 15/6/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    var sharedModelContainer = SharedModelContainer().container
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TodoListView(userId: viewModel.currentUserId)
                .modelContainer(sharedModelContainer)
        } else {
            LoginView()
                .modelContainer(sharedModelContainer)
        }
    }
}

#Preview {
    MainView()
}
