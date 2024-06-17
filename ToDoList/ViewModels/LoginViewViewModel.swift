//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseAuth
import CoreData
import FirebaseFirestore
import SwiftData

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var loginErrorMessage = ""
    @Published var showAlert = 0
    
    init() {}
    
    func login(modelContext: ModelContext) {
        
        guard validate() else {
            return
        }
        
        // Try to log in
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard error == nil else {
                self?.loginErrorMessage = error?.localizedDescription ?? "An error occurred."
                self?.showAlert += 1
                return
            }
            
            guard let user = result?.user else {
                self?.loginErrorMessage = "An error occurred."
                self?.showAlert += 1
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(user.uid)
                .getDocument { document, error in
                    guard let document = document, document.exists else {
                        self?.loginErrorMessage = "An error occurred."
                        self?.showAlert += 1
                        return
                    }
                    
                    guard let documentData = document.data() else {
                        return
                    }
                    
                    let url = URL(string: "https://i.pravatar.cc/300?u=a")
                    getData(from: url!) { imageData, response, error in
                        guard let imageData = imageData, error == nil else {
                            return
                        }
                        
                        let userData = User(
                            id: documentData["id"] as? String ?? "",
                            name: documentData["email"] as? String ?? "",
                            email: documentData["name"] as? String ?? "",
                            joined: documentData["joined"] as? TimeInterval ?? Date().timeIntervalSince1970,
                            image: imageData
                        )
                        
                        modelContext.insert(userData)
                    }
                }
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
