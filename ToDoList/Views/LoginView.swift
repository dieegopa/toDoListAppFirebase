//
//  LoginView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                HeaderView(title: "To Do List",
                           subtitle: "Get things done",
                           background: .green,
                           padding: 0
                )
                
                Form {
                    
                    VStack {
                        TextField("Email", text: $viewModel.email)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.green.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.horizontal, 2)
                            .tint(.green)
                        
                        
                        SecureField("Password", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.green.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.horizontal, 2)
                            .tint(.green)
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(Color.red.opacity(0.8))
                                .background(Color(UIColor.systemBackground))
                        }
                        
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color(UIColor.systemBackground))
                    .padding(.top, -10)
                    .padding(.bottom, -10)
                    
                    Section {
                        TLButton(title: "Log in", background: .green)
                        {
                            if(!viewModel.showAlert) {
                                viewModel.login()
                            }
                        }
                    }
                    
                }
                .offset(y: -50)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .background(Color(UIColor.systemBackground))
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error") , message: Text(viewModel.loginErrorMessage)
                    )
                }
                
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an account",
                                   destination: RegisterView()
                    )
                    .foregroundColor(.green)
                }
                .padding([.top, .bottom], 25)
                
                Spacer()
            }
        }
        .tint(.black)
    }
}

#Preview {
    LoginView()
}
