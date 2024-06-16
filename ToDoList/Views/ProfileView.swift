//
//  ProfileView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI
import Shimmer

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @FetchRequest(sortDescriptors: []) private var userCore: FetchedResults<UserCore>
    
    var body: some View {
        NavigationView {
            VStack {
                profile(user: userCore.first!)
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
    func profile(user: UserCore) -> some View {
        let url = URL(string: "https://i.pravatar.cc/300?u=a")
        let transaction = Transaction(animation: Animation.easeIn(duration: 2.0))
        
        AsyncImage(url: url, transaction: transaction) { image in
            switch image {
            case .empty:
                Circle()
                    .foregroundColor(.secondary)
                    .redacted(reason: .placeholder)
                    .shimmering()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                
            case .failure(let err):
                Circle()
                    .foregroundColor(.secondary)
                    .redacted(reason: .placeholder)
                    .shimmering()
            @unknown default:
                EmptyView()
            }
        }
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
