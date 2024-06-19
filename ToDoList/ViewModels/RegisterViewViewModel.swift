//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftData

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var registerAttemps = 0
    
    init() {}
    
    func register(modelContext: ModelContext) {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let userId = result?.user.uid else {
                self!.showAlert.toggle()
                self!.registerAttemps += 1
                return
            }
            
            let url = URL(string: "https://i.pravatar.cc/300?u=a")
            getData(from: url!) { imageData, response, error in
                guard let imageData = imageData, error == nil else {
                    return
                }
                
                let newUser = User(
                    id: userId,
                    name: self!.name,
                    email: self!.email,
                    joined: Date().timeIntervalSince1970,
                    image: imageData
                )
                
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(userId)
                    .setData(newUser.asDictionary())
                
                modelContext.insert(newUser)
                UserDefaults.standard.set(true, forKey: "isLogged")
            }
        }
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            showAlert.toggle()
            registerAttemps += 1
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            showAlert.toggle()
            registerAttemps += 1
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password should be at least 6 characters"
            showAlert.toggle()
            registerAttemps += 1
            return false
        }
        
        return true
        
    }
}
