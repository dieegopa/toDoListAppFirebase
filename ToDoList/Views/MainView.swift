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
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
                .modelContainer(sharedModelContainer)
        } else {
            LoginView()
                .modelContainer(sharedModelContainer)
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        ZStack {
            VStack{
                TabView {
                    if viewModel.selectedTab == .house {
                        TodoListView(userId: viewModel.currentUserId)
                    } else if viewModel.selectedTab == .person {
                        ProfileView()
                    }
                }
                .transition(.scale)
                
                Spacer()
                CustomTabBarView(selectedTab: $viewModel.selectedTab)
                
            }
        }
    }
}

#Preview {
    MainView()
}
