//
//  NotificationCountView.swift
//  ToDoList
//
//  Created by Diego Padilla on 16/6/24.
//

import SwiftUI
import Pow

struct NotificationCountView : View {
    
    @Binding var value: Int
    
    private let foreground: Color = Color(UIColor.secondarySystemBackground)
    private let background: Color = .primary
    private let size = 16.0
    private let x = 22.0
    private let y = 0.0
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(background)
                .frame(width: size * widthMultplier(), height: size, alignment: .topTrailing)
                .position(x: x, y: y)
                .animation(.easeIn(duration: 0.1), value: value)
            if hasTwoOrLessDigits() {
                Text("\(value)")
                    .foregroundColor(foreground)
                    .font(Font.caption)
                    .position(x: x, y: y)
                    .animation(.easeIn(duration: 0.1), value: value)
            } else {
                Text("99+")
                    .foregroundColor(foreground)
                    .font(Font.caption)
                    .frame(width: size * widthMultplier(), height: size, alignment: .center)
                    .position(x: x, y: y)
                    .animation(.easeIn(duration: 0.1), value: value)
            }
        }
        .opacity(value == 0 ? 0 : 1)
        .animation(.easeIn(duration: 0.1), value: value)
    }
    
    func hasTwoOrLessDigits() -> Bool {
        return value < 100
    }
    
    func widthMultplier() -> Double {
        if value < 10 {
            return 1.0
        } else if value < 100 {
            return 1.5
        } else {
            return 2.0
        }
    }
}

#Preview {
    NotificationCountView(value: .constant(10))
}
