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
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack{
                HeaderView(title: "To Do",
                           padding: 0
                )
                
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.alphabet)
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
                        .changeEffect(.shake(rate: .fast), value: viewModel.loginAttemps)
                    
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
                        .changeEffect(.shake(rate: .fast), value: viewModel.loginAttemps)
                    
                    if viewModel.showAlert {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red.opacity(0.8))
                            .background(Color(UIColor.systemBackground))
                            .transition(.movingParts.blur)
                    }
                    
                    TLButton(title: "Log in", isLoading: viewModel.tryingToLogin, background: .green) {
                        
                        withAnimation {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            viewModel.tryingToLogin = true
                            viewModel.login(modelContext: modelContext)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                if(viewModel.showAlert) {
                                    viewModel.showAlert.toggle()
                                    viewModel.tryingToLogin.toggle()
                                }
                            }
                        }
                    }
                    .disabled(viewModel.showAlert || viewModel.tryingToLogin)
                    .animation(.default, value: viewModel.tryingToLogin || viewModel.showAlert)
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
                    .bold()
                    .foregroundColor(.green)
                }
                .padding([.top, .bottom], 25)
                
                Spacer()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .tint(.primary)
    }
}

#Preview {
    LoginView()
}
