//
//  User.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation

struct User: Codable, Equatable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    
    static let sample = User(id: "", name: "", email: "", joined: 0)
}
