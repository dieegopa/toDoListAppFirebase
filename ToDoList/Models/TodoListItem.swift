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
    
    static let example = [
        TodoListItem(id: "1", title: "Buy groceries", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "2", title: "Finish project", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "3", title: "Call mom", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "4", title: "Go to the gym", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "5", title: "Read book", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "6", title: "Finish project", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "7", title: "Call mom", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "8", title: "Go to the gym", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "9", title: "Read book", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "10", title: "Finish project", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
        TodoListItem(id: "11", title: "Call mom", dueDate: Date().addingTimeInterval(86400).timeIntervalSince1970, createdDate: Date().addingTimeInterval(86400).timeIntervalSince1970, tag: "Normal", isDone: false),
    ]
}
