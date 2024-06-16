//
//  NewItemViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var dueDate = Date()
    @Published var tag: AnimationModeTag = .normal
    @Published var showAlert = false
    
    init() {}
    
    func save(item: TodoListItem? = nil, completion: TimeInterval? = 0) {
        guard canSave else {
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        if item != nil {
            db.collection("users")
                .document(userId)
                .collection("todos")
                .document(item!.id)
                .updateData([
                    "title": title,
                    "dueDate": dueDate.timeIntervalSince1970,
                    "isDone": item?.title == title && item?.dueDate == dueDate.timeIntervalSince1970 && item?.isDone == true ? true : false,
                    "tag": tag.title
                ])
        } else {
            let newId = UUID().uuidString
            let newItem = TodoListItem(
                id: newId,
                title: title,
                dueDate: dueDate.timeIntervalSince1970,
                createdDate: Date().timeIntervalSince1970,
                tag: tag.title,
                isDone: false
            )
            
            
            db.collection("users")
                .document(userId)
                .collection("todos")
                .document(newId)
                .setData(newItem.asDictionary())
        }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
