//
//  RegisterView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack{
            // Header
            HeaderView(title: "Register", 
                       subtitle: "Start organizing todos",
                       background: .orange,
                       padding: -40)
            
            Form {
                VStack {
                    TextField("Full Name", text: $viewModel.name)
                        .autocorrectionDisabled()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.horizontal, 2)
                        .tint(.orange)
                    
                    TextField("Email Adress", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.horizontal, 2)
                        .tint(.orange)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.horizontal, 2)
                        .tint(.orange)
                    
                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color(UIColor.systemBackground))
                .padding(.top, -10)
                .padding(.bottom, -10)
                
                Section {
                    TLButton(title: "Create account", background: .orange) {
                        viewModel.register()
                    }
                }
                
            }
            .offset(y: -50)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .background(Color(UIColor.systemBackground))
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    RegisterView()
}
