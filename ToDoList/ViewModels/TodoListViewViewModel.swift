//
//  TodoListViewViewModel.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import FirebaseFirestore

class TodoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingEditItemView = false
    @Published var editingItem: TodoListItem?
    @Published var pendingItemsCount = 0
    @Published var expiredItemsCount = 0
    @Published var completedItemsCount = 0
    @Published var filteredExpired = false
    @Published var filteredCompleted = false
    @Published var filteredPending = false
    @Published var itemsCopy: [TodoListItem] = []
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete a todo item
    /// - Parameter id: The id of the todo item to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
}
