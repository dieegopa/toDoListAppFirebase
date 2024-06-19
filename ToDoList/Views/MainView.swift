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
        VStack {
            if viewModel.isLogged {
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                    TodoListView(userId: viewModel.currentUserId)
                        .modelContainer(for: User.self)
                } else {
                    ProgressView()
                        .controlSize(.large)
                        .tint(.primary)
                        .transition(.movingParts.blur)
                }
            } else {
                LoginView()
                    .modelContainer(for: User.self)
            }
        }.onChange(of: viewModel.isSignedIn) { oldValue, newValue in
            withAnimation {
                viewModel.isLogged.toggle()
            }
        }
    }
}

#Preview {
    MainView()
}
