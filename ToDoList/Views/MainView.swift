//
//  ContentView.swift
//  ToDoList
//
//  Created by Diego Padilla on 15/6/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @StateObject private var manager: CoreDataManager = CoreDataManager()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        } else {
            LoginView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
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
