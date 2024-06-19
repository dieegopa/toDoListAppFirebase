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
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TodoListView(userId: viewModel.currentUserId)
                .modelContainer(for: User.self)
        } else {
            LoginView()
                .modelContainer(for: User.self)
        }
    }
}

#Preview {
    MainView()
}
