//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewViewModel: ObservableObject {
    init() {}
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
