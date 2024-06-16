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
            Color(background).opacity(0.8)
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
        }
        .listRowInsets(EdgeInsets())
    }
}

#Preview {
    TLButton(title: "Tittle", background: .blue) {
        // Action
    }
}
