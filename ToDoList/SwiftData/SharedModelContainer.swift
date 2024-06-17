//
//  SharedModelContainer.swift
//  ToDoList
//
//  Created by Diego Padilla on 17/6/24.
//

import Foundation
import SwiftData

class SharedModelContainer {
    
    var container: ModelContainer
    
    init() {
        let schema = Schema([
            User.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
