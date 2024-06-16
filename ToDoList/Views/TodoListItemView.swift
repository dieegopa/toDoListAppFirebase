//
//  TodoListItemView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI
import Pow

struct TodoListItemView: View {
    @StateObject var viewModel = TodoListItemViewViewModel()
    @Environment(\.colorScheme) var colorScheme
    let item: TodoListItem
    
    var body: some View {
        VStack {
            GroupBox {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .white : Color(.secondaryLabel))
                    }
                    
                    Spacer()
                    
                    if item.isDone {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .transition(
                                .movingParts.pop(.green)
                            )
                            .font(.title2)
                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(.secondary)
                            .transition(.identity)
                            .font(.title2)
                    }
                    
                }
            } label : {
                HStack {
                    Image(systemName: "square.fill")
                        .foregroundColor(
                            item.tag == "Urgent" ? .red :
                                item.tag == "Important" ? .yellow :
                                item.tag == "Normal" ? .blue :
                                    .primary
                        )
                    Text(item.title)
                }
            }
            .onTapGesture {
                viewModel.toggleIsDone(item: item)
            }
            .backgroundStyle(colorScheme == .dark ? Material.regularMaterial : Material.ultraThinMaterial)
            .foregroundColor(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .white : .primary)
            
            .opacity(item.isDone ? 0.5 : 1.0)
        }
        .background(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .red : .clear)
        .cornerRadius(10)
    }
}

#Preview {
    TodoListItemView(
        item: .init(
            id: "1",
            title: "Test",
            dueDate: Date().timeIntervalSince1970 + 1000,
            createdDate: Date().timeIntervalSince1970,
            tag: "Important",
            isDone: false
        )
    )
}
