//
//  AnimationsFilterView.swift
//  ToDoList
//
//  Created by Diego Padilla on 16/6/24.
//

import SwiftUI

struct AnimationsFilterView: View {
    @Environment(\.colorScheme) var colorScheme
    let color = Color.gray
    
    @Binding var pendingItemsCount: Int
    @Binding var completedItemsCount: Int
    @Binding var expiredItemsCount: Int
    @Binding var allItemsCount: Int
    @Binding var filterSelected: AnimationModeFilter
    @Binding var items : [TodoListItem]
    @Binding var itemsCopy : [TodoListItem]
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(AnimationModeFilter.allCases.indices, id: \.self) { index in
                    let mode = AnimationModeFilter.allCases[index]
                    let makeDivider = index < AnimationModeFilter.allCases.count - 1
                    
                    Button {
                        filterSelected = mode
                        
                        itemsCopy = items.filter {
                            filterSelected.title == "Pending" ? !$0.isDone && $0.dueDate > Date().timeIntervalSince1970 :
                            filterSelected.title == "Completed" ? $0.isDone :
                            filterSelected.title == "Expired" ? $0.dueDate < Date().timeIntervalSince1970 : true
                            
                        }
                        
                    } label: {
                        VStack(spacing: 7) {
                            Image(systemName: mode.imageName)
                                .font(.title3)
                                .overlay(alignment: .topLeading) {
                                    NotificationCountView(value: mode.title == "All" ? $allItemsCount : mode.title == "Pending" ? $pendingItemsCount : mode.title == "Completed" ? $completedItemsCount : $expiredItemsCount)
                                }
                            
                            Text(mode.title)
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .padding(.vertical, 8)
                        .foregroundColor(.primary)
                        
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(BouncyButton())
                    
                    if makeDivider {
                        if !(index == filterSelected.rawValue || (index + 1) == filterSelected.rawValue )  {
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
                    let caseCount = AnimationModeFilter.allCases.count
                    color.opacity(0.15)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: proxy.size.width / CGFloat(caseCount))
                    // Offset the background horizontally based on the selected animation mode
                        .offset(x: proxy.size.width / CGFloat(caseCount) * CGFloat(filterSelected.rawValue))
                }
            }
            .background {
                Color(.systemBackground)
                    .opacity(0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))
                
            }
            .padding(.horizontal, 20)
            .animation(.smooth, value: filterSelected)
            
        }
    }
}

#Preview {
    AnimationsFilterView(pendingItemsCount: .constant(3),
                         completedItemsCount: .constant(2),
                         expiredItemsCount: .constant(1),
                         allItemsCount: .constant(6),
                         filterSelected: .constant(.all),
                         items: .constant([TodoListItem(id: "1", title: "Test", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, tag: "Normal", isDone: false)]),
                         itemsCopy: .constant([TodoListItem(id: "1", title: "Test", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, tag: "Normal", isDone: false)])
    )
}
