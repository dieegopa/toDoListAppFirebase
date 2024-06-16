//
//  AnimationsView.swift
//  ToDoList
//
//  Created by Diego Padilla on 16/6/24.
//

import SwiftUI

struct AnimationsTagView: View {
    @Binding var tagSelected: AnimationModeTag
    @Environment(\.colorScheme) var colorScheme
    let color = Color.indigo
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(AnimationModeTag.allCases.indices, id: \.self) { index in
                    let mode = AnimationModeTag.allCases[index]
                    let makeDivider = index < AnimationModeTag.allCases.count - 1
                    
                    Button {
                        tagSelected = mode
                    } label: {
                        VStack(spacing: 7) {
                            Image(systemName: mode.imageName)
                                .font(.title2)
                            
                            Text(mode.title)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .padding(.vertical, 13)
                        .foregroundColor(mode.color)
                        
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(BouncyButton())
                    
                    if makeDivider {
                        if !(index == tagSelected.rawValue || (index + 1) == tagSelected.rawValue )  {
                            Divider()
                                .frame(width: 0, height: 55)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 2)
            .background {
                GeometryReader { proxy in
                    let caseCount = AnimationModeTag.allCases.count
                    color.opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .frame(width: proxy.size.width / CGFloat(caseCount))
                        .offset(x: proxy.size.width / CGFloat(caseCount) * CGFloat(tagSelected.rawValue))
                }
            }
            .background {
                Color(.systemBackground)
                    .opacity(0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))
                
            }
            .animation(.smooth, value: tagSelected)
        }
    }
}

#Preview {
    AnimationsTagView(tagSelected: .constant(.normal))
}
