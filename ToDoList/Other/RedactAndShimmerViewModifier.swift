//
//  RedactAndShimmerViewModifier.swift
//  ToDoList
//
//  Created by Diego Padilla on 17/6/24.
//

import Foundation
import SwiftUI

public struct RedactAndShimmerViewModifier: ViewModifier {
    private let condition: Bool
    
    
    init(condition: Bool) {
        self.condition = condition
    }
    
    public func body(content: Content) -> some View {
        if condition {
            content
                .redacted(reason: .placeholder)
                .shimmering()
        } else {
            content
        }
    }
}
