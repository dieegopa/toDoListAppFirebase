//
//  TodoListItemView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI

struct TodoListItemView: View {
    @StateObject var viewModel = TodoListItemViewViewModel()
    let item: TodoListItem
    
    var body: some View {
        GroupBox(item.title) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .red : Color(.secondaryLabel))
                }
                
                Spacer()
                
                Button {
                    viewModel.toggleIsDone(item: item)
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.dueDate < Date().timeIntervalSince1970 && !item.isDone ? .red : .green)
                        .font(.title2)
                }
            }
        }
        .onTapGesture {
            viewModel.toggleIsDone(item: item)
        }
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
            isDone: true
        )
    )
}
