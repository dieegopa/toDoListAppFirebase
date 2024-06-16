//
//  AnimationMode.swift
//  ToDoList
//
//  Created by Diego Padilla on 16/6/24.
//

import Foundation
import SwiftUI

enum AnimationModeTag: Int, CaseIterable {
    case normal
    case important
    case urgent
    
    var imageName: String {
        switch self {
        case .normal:
            return "figure.walk"
        case .important:
            return "figure.walk.motion"
        case .urgent:
            return "figure.walk.motion.trianglebadge.exclamationmark"
        }
    }
    var title: String {
        switch self {
        case .normal:
            return "Normal"
        case .important:
            return "Important"
        case .urgent:
            return "Urgent"
        }
    }
    
    var color: Color {
        switch self {
        case .normal:
            return .blue
        case .important:
            return .yellow
        case .urgent:
            return .red
        }
    }
}
