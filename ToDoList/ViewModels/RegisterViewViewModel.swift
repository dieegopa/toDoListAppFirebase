//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = 0
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let userId = result?.user.uid else {
                self?.showAlert += 1
                return
            }
            
            self?.inserUserRecord(id: userId)
        }
    }
    
    private func inserUserRecord(id: String) {
        
        let url = URL(string: "https://i.pravatar.cc/300?u=a")
        getData(from: url!) { imageData, response, error in
            guard let imageData = imageData, error == nil else {
                return
            }
            
            let newUser = User(
                id: id,
                name: self.name,
                email: self.email,
                joined: Date().timeIntervalSince1970,
                image: imageData
            )
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(id)
                .setData(newUser.asDictionary())
        }
        
        
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password should be at least 6 characters"
            return false
        }
        
        return true
        
    }
}
