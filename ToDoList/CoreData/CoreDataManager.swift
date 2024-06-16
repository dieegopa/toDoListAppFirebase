//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Diego Padilla on 17/6/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    @Published var userCore: UserCore = UserCore()
    let container : NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "ToDoList")
        
        setupDatabase()
    }
    
    
    private func setupDatabase() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
            print("Database ready!")
        }
    }
}
