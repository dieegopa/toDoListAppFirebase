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
                
                AnimationsFilterView(
                    pendingItemsCount: $viewModel.pendingItemsCount,
                    completedItemsCount: $viewModel.completedItemsCount,
                    expiredItemsCount: $viewModel.expiredItemsCount,
                    allItemsCount: $viewModel.allItemsCount,
                    filterSelected: $viewModel.filter,
                    items: .constant(items),
                    itemsCopy: $viewModel.itemsCopy
                )
                
                
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
                .onChange(of: items, perform: { value in
                    viewModel.pendingItemsCount = value.filter { !$0.isDone && $0.dueDate > Date().timeIntervalSince1970 }.count
                    
                    viewModel.expiredItemsCount = value.filter { !$0.isDone && $0.dueDate < Date().timeIntervalSince1970 }.count
                    
                    viewModel.completedItemsCount = value.filter { $0.isDone }.count
                    
                    viewModel.allItemsCount = value.count
                    
                    viewModel.itemsCopy = value
                })
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
