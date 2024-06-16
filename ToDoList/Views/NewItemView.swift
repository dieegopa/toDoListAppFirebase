//
//  NewItemView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    private var editItem: TodoListItem?
    
    init(newItemPresented: Binding<Bool>, editItem: TodoListItem? = nil) {
        self._newItemPresented = newItemPresented
        self.editItem = editItem
    }
    
    var body: some View {
        VStack {
            Text(editItem == nil ? "New Item" : "Edit Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 30)
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                AnimationsTagView(tagSelected: $viewModel.tag)
                
                // Button
                Section {
                    TLButton(title: "Save", background: .green) {
                        if viewModel.canSave {
                            viewModel.save(item: editItem)
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error") , message: Text("Please fill in all fields and select due date that is today or newer.")
                )
            }
        }
        .onAppear{
            if let editItem = editItem {
                viewModel.title = editItem.title
                viewModel.dueDate = Date(timeIntervalSince1970: editItem.dueDate)
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
    }))
}
