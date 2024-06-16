//
//  TodoListItem.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation

struct TodoListItem: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    let tag: String
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
