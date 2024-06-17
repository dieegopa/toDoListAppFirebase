//
//  User.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import Foundation
import SwiftData

@Model
final class User: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case joined
        case image
    }
    
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    let image: Data?
    
    init(id: String, name: String, email: String, joined: TimeInterval, image: Data? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.joined = joined
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        joined = try container.decode(TimeInterval.self, forKey: .joined)
        image = try container.decodeIfPresent(Data.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(joined, forKey: .joined)
        try container.encodeIfPresent(image, forKey: .image)
    }
}
