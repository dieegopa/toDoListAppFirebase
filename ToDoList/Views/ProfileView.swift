//
//  ProfileView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI
import Shimmer
import SwiftData

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @Query private var user: [User]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                profile(user: user.first!)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .padding(.top, 20)
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        Image(uiImage: UIImage(data: user.image!)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(width: 120, height: 120)
            .padding(.bottom, 20)
        
        VStack(alignment:.leading) {
            HStack {
                Text("Name:")
                    .bold()
                Text(user.name)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
            HStack {
                Text("Email:")
                    .bold()
                Text(user.email)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
            HStack {
                Text("Member Since:")
                    .bold()
                Text(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
        }
        
        Form {
            TLButton(title: "Sign out", background: .red) {
                modelContext.container.deleteAllData()
                viewModel.signOut()
            }
        }
        .scrollDisabled(true)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ProfileView()
}
