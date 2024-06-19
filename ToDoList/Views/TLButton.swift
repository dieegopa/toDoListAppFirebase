//
//  TLButton.swift
//  ToDoList
//
//  Created by Diego Padilla on 15/6/24.
//

import SwiftUI
import Pow

struct TLButton: View {
    let title: String
    let isLoading: Bool
    let background: Color
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }) {
                VStack {
                    if(isLoading) {
                        ProgressView()
                            .tint(.primary)
                    } else {
                        Text(title)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
                .bold()
            }
            .foregroundColor(.white)
            .buttonStyle(CustomButtonStyle(backgroundColor: background, pressedColor: background.opacity(0.5)))
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
        .scrollContentBackground(.hidden)
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
            .background(background, in: Rectangle())
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.75 : 1)
            .conditionalEffect(
                .pushDown,
                condition: configuration.isPressed
            )
    }
}

#Preview {
    TLButton(title: "Tittle", isLoading: true, background: .blue) {
        // Action
    }
}
