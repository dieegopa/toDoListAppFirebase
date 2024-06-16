//
//  AnimationModeFilter.swift
//  ToDoList
//
//  Created by Diego Padilla on 16/6/24.
//

import Foundation
import SwiftUI

enum AnimationModeFilter: Int, CaseIterable {
    case all
    case completed
    case pending
    case expired
    
    var imageName: String {
        switch self {
        case .all:
            return "tray.fill"
        case .completed:
            return "checkmark.seal.fill"
        case .pending:
            return "questionmark.app.fill"
        case .expired:
            return "exclamationmark.circle.fill"
        }
    }
    var title: String {
        switch self {
        case .all:
            return "All"
        case .completed:
            return "Completed"
        case .pending:
            return "Pending"
        case .expired:
            return "Expired"
        }
    }
    
    var color: Color {
        switch self {
        case .all:
            return .primary
        case .completed:
            return .green
        case .pending:
            return .blue
        case .expired:
            return .red
        }
    }
}
