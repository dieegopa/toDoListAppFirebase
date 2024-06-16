//
//  UserCore+CoreDataProperties.swift
//  ToDoList
//
//  Created by Diego Padilla on 17/6/24.
//
//

import Foundation
import CoreData


extension UserCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCore> {
        return NSFetchRequest<UserCore>(entityName: "UserCore")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var joined: Double

}

extension UserCore : Identifiable {

}
