//
//  TLButton.swift
//  ToDoList
//
//  Created by Diego Padilla on 15/6/24.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        
        ZStack {
            Color(UIColor(background)).opacity(0.8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                action()
            }) {
                Text(title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .bold()
            }
            .foregroundColor(.white)
            .buttonStyle(CustomButtonStyle(backgroundColor: background, pressedColor: background.opacity(0.5)))
        }
        .listRowInsets(EdgeInsets())
    }
}

private struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let pressedColor: Color

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let background = configuration.isPressed ? pressedColor : backgroundColor

        configuration.label
            .foregroundColor(.white)
            .background(background)
            .cornerRadius(8)
    }
}

#Preview {
    TLButton(title: "Tittle", background: .blue) {
        // Action
    }
}
