//
//  LoginView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI
import Pow

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
                
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(.horizontal, 10)
                        .tint(.green)
                        .padding(.vertical, 15)
                        .background(Material.thinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondary.opacity(0.3), lineWidth: 1)
                        )
                        .changeEffect(.shake(rate: .fast), value: viewModel.showAlert)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(.horizontal, 10)
                        .tint(.green)
                        .padding(.vertical, 15)
                        .background(Material.thinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondary.opacity(0.3), lineWidth: 1)
                        )
                        .changeEffect(.shake(rate: .fast), value: viewModel.showAlert)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red.opacity(0.8))
                            .background(Color(UIColor.systemBackground))
                            .animation(.easeInOut(duration: 3), value: viewModel.errorMessage)
                            .task {
                                viewModel.showAlert += 1
                                try? await Task.sleep(nanoseconds: 2_500_000_000)
                                viewModel.errorMessage = ""
                            }
                    }
                    
                    if !viewModel.loginErrorMessage.isEmpty {
                        Text("Invalid credentials")
                            .foregroundColor(Color.red.opacity(0.8))
                            .background(Color(UIColor.systemBackground))
                            .animation(.easeInOut(duration: 3), value: viewModel.loginErrorMessage)
                            .task {
                                try? await Task.sleep(nanoseconds: 2_500_000_000)
                                viewModel.loginErrorMessage = ""
                            }
                    }
                    
                    TLButton(title: "Log in", background: .green)
                    {
                        viewModel.login()
                    }
                    .frame(height: 50)
                }
                .offset(y: -50)
                .padding(.horizontal, 20)
                
                
                
                VStack {
                    Spacer()
                    Text("New around here?")
                    NavigationLink("Create an account",
                                   destination: RegisterView()
                    )
                    .foregroundColor(.green)
                }
                .padding([.top, .bottom], 25)
                
                Spacer()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .tint(.black)
    }
}

#Preview {
    LoginView()
}
