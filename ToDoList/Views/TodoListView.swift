//
//  TodoListItemsView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TodoListView: View {
    
    @StateObject var viewModel: TodoListViewViewModel
    @FirestoreQuery var items: [TodoListItem]
    private let adaptiveColumn = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150)),
    ]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos",
            predicates: [
                .order(by: "isDone", descending: true),
                .order(by: "dueDate", descending: false)
            ]
        )
        
        self._viewModel = StateObject(
            wrappedValue: TodoListViewViewModel(userId: userId)
        )
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        GroupBox {
                            HStack {
                                Label("Expired", systemImage: "exclamationmark.circle.fill")
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text(String(viewModel.expiredItemsCount))
                                    .bold()
                            }
                        }
                        .onTapGesture {
                            if(viewModel.filteredExpired) {
                                viewModel.filteredExpired = false
                                viewModel.itemsCopy = items
                            } else {
                                viewModel.filteredExpired = true
                                viewModel.filteredPending = false
                                viewModel.filteredCompleted = false
                                let itemsFiltered = items.filter { !$0.isDone && $0.dueDate < Date().timeIntervalSince1970 }
                                viewModel.itemsCopy = itemsFiltered
                            }
                        }
                        
                        GroupBox {
                            HStack {
                                Label("Pending", systemImage: "questionmark.app.fill")
                                    .bold()
                                    .foregroundColor(.blue)
                                Text(String(viewModel.pendingItemsCount))
                                    .bold()
                            }
                        }
                        .onTapGesture {
                            if(viewModel.filteredPending) {
                                viewModel.filteredPending = false
                                viewModel.itemsCopy = items
                            } else {
                                viewModel.filteredPending = true
                                viewModel.filteredExpired = false
                                viewModel.filteredCompleted = false
                                let itemsFiltered = items.filter { !$0.isDone && $0.dueDate > Date().timeIntervalSince1970 }
                                viewModel.itemsCopy = itemsFiltered
                            }
                        }
                    }
                        
                    HStack(alignment: .center) {
                        GroupBox {
                            HStack {
                                Label("Completed", systemImage: "checkmark.seal.fill")
                                    .bold()
                                    .foregroundColor(.green)
                                
                                Text(String(viewModel.completedItemsCount))
                                    .bold()
                            }
                        }
                        .onTapGesture {
                            if(viewModel.filteredCompleted) {
                                viewModel.filteredCompleted = false
                                viewModel.itemsCopy = items
                            } else {
                                viewModel.filteredCompleted = true
                                viewModel.filteredPending = false
                                viewModel.filteredExpired = false
                                let itemsFiltered = items.filter { $0.isDone }
                                viewModel.itemsCopy = itemsFiltered
                            }
                        }
                        
                        GroupBox {
                            HStack {
                                Label("All", systemImage: "tray.fill")
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Text(String(items.count))
                                    .bold()
                            }
                        }
                        .onTapGesture {
                            viewModel.filteredExpired = false
                            viewModel.filteredPending = false
                            viewModel.filteredCompleted = false
                            viewModel.itemsCopy = items
                        }
                    }
                }
               
                
                List(viewModel.itemsCopy) { item in
                    TodoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                            
                            Button("Edit") {
                                viewModel.showingEditItemView = true
                                viewModel.editingItem = item
                            }
                            .tint(.orange)
                        }
                        .listRowSeparator(.hidden)
                        .onLongPressGesture(perform: {
                            viewModel.showingEditItemView = true
                            viewModel.editingItem = item
                        })
                }
                .listStyle(.plain)
                .onChange(of: items) {
                    viewModel.pendingItemsCount = items.filter { !$0.isDone && $0.dueDate > Date().timeIntervalSince1970 }.count
                    
                    viewModel.expiredItemsCount = items.filter { !$0.isDone && $0.dueDate < Date().timeIntervalSince1970 }.count
                    
                    viewModel.completedItemsCount = items.filter { $0.isDone }.count
                    
                    viewModel.itemsCopy = items
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("To Do's")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .tint(.green)
                }
                
            }
            .padding(.top, 20)
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .sheet(isPresented: $viewModel.showingEditItemView) {
                NewItemView(newItemPresented: $viewModel.showingEditItemView, editItem: viewModel.editingItem)
            }
        }
    }
}

#Preview {
    TodoListView(userId: "KDLJDkRPQdeY1QEGqKK288mzPIC3")
}
