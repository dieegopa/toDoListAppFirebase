//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var loginErrorMessage = ""
    @Published var showAlert = false
    
    init() {}
    
    func login() {
        
        guard validate() else {
            return
        }
        
        // Try to log in
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard error == nil else {
                self?.loginErrorMessage = error?.localizedDescription ?? "An error occurred."
                self?.showAlert = true
                return
            }
            
            self?.showAlert = false
            self?.loginErrorMessage = ""
        }
        
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        return true
    
    }
}
