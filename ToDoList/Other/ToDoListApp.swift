//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Diego Padilla on 15/6/24.
//

import SwiftUI
import FirebaseCore
import SwiftData

@main
struct ToDoListApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
