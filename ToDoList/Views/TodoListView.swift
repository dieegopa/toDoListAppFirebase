//
//  TodoListItemsView.swift
//  ToDoList
//
//  Created by Diego Padilla on 14/6/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import SwiftData
import Shimmer
import Pow

struct TodoListView: View {
    
    @StateObject var viewModel: TodoListViewViewModel
    @FirestoreQuery var items: [TodoListItem]
    private var userImageData = UserDefaults.standard.data(forKey: "userImageData") ?? nil
    var dummyData : [TodoListItem] = TodoListItem.dummyData
    @State private var isLoading : Bool = true
    
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
                
                List(isLoading ? dummyData : viewModel.itemsCopy ) { item in
                    TodoListItemView(item: item)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading) {
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
                        .transition(.movingParts.wipe(
                                    angle: .degrees(-45),
                                    blurRadius: 50
                                  ))
                        .redactShimmer(condition: isLoading)
                }
                .listStyle(.plain)
                .onChange(of: items, { oldValue, newValue in
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            if(isLoading) {
                                isLoading.toggle()
                            }
                        }
                    }
                    
                    viewModel.pendingItemsCount = newValue.filter { !$0.isDone && $0.dueDate > Date().timeIntervalSince1970 }.count
                    
                    viewModel.expiredItemsCount = newValue.filter { !$0.isDone && $0.dueDate < Date().timeIntervalSince1970 }.count
                    
                    viewModel.completedItemsCount = newValue.filter { $0.isDone }.count
                    
                    viewModel.allItemsCount = newValue.count
                    
                    viewModel.itemsCopy = newValue
                })
                .onAppear {
                    if(items.isEmpty) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                if(isLoading) {
                                    isLoading.toggle()
                                }
                            }
                        }
                    }
                }
                
                HStack(alignment: .bottom) {
                    
                    Spacer()
                    
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .contentShape(Rectangle())
                            .foregroundColor(.primary)
                            .frame(maxWidth: 40, maxHeight: 40)
                            .scaleEffect(1.25)
                            .font(.system(size: 40))
                    }
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 30)
                
                
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .principal) {
                    Text("To Do's")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        if userImageData == nil {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                        } else {
                            Image(uiImage: UIImage(data: userImageData!)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                        }
                    }
                    
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
        .tint(.primary)
    }
}

#Preview {
    TodoListView(userId: "KDLJDkRPQdeY1QEGqKK288mzPIC3")
}
