//
//  ContentView.swift
//  ToDoList
//
//  Created by Diego Padilla on 15/6/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
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
