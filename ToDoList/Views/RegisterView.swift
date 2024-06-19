//
//  RegisterView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack{
            // Header
            HeaderView(title: "Register", 
                       subtitle: "Start organizing todos",
                       background: .orange,
                       padding: -40)
            
            VStack {
                TextField("Full Name", text: $viewModel.name)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 10)
                    .tint(.orange)
                    .padding(.vertical, 15)
                    .background(Material.thinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .changeEffect(.shake(rate: .fast), value: viewModel.registerAttemps)
                
                TextField("Email", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 10)
                    .tint(.orange)
                    .padding(.vertical, 15)
                    .background(Material.thinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .changeEffect(.shake(rate: .fast), value: viewModel.registerAttemps)
                
                SecureField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 10)
                    .tint(.orange)
                    .padding(.vertical, 15)
                    .background(Material.thinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .changeEffect(.shake(rate: .fast), value: viewModel.registerAttemps)
                
                if viewModel.showAlert {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red.opacity(0.8))
                        .background(Color(UIColor.systemBackground))
                        .transition(.movingParts.blur)
                }
                
                TLButton(title: "Create account", background: .orange) {
                    withAnimation {
                        viewModel.register(modelContext: modelContext)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            if(viewModel.showAlert) {
                                viewModel.showAlert.toggle()
                            }
                        }
                    }
                    
                }
                .frame(height: 50)
            }
            .offset(y: -50)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    RegisterView()
}
