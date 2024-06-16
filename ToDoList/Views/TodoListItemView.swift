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
    let item: TodoListItem
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .red : Color(.secondaryLabel))
                }
                
                Spacer()
                
                if item.isDone {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.red)
                        .transition(
                            .movingParts.pop(.red)
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
        .backgroundStyle(Material.thinMaterial)
        .foregroundColor(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .red : .primary)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? Color.red : Color(.separator), lineWidth: 1)
        )
        .opacity(item.isDone ? 0.5 : 1.0)
    }
}

#Preview {
    TodoListItemView(
        item: .init(
            id: "1",
            title: "Test",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            tag: "Important",
            isDone: true
        )
    )
}
