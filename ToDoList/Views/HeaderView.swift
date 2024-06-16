//
//  HeaderView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let background: Color
    let padding: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [background, .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .zIndex(1.0)
            VStack {
                Text(title)
                    .font(.system(size: 40))
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 20))
            }
            .zIndex(2.0)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -100)
        .padding(.top, padding)
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "Subtitle", background: .green, padding: 0)
}
