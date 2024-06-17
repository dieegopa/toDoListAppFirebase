//
//  CustomTabBarView.swift
//  ToDoList
//
//  Created by Diego Padilla on 16/6/24.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var selectedTab : Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    //                    Button{
                    //                        withAnimation(.easeIn(duration: 0.1)) {
                    //                            selectedTab = tab
                    //                        }
                    //                    } label: {
                    //                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    //                            .contentShape(Rectangle())
                    //                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                    //                    }
                    //                    .foregroundColor(.primary)
                    //                    .font(.system(size: 20))
                    //                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    //                    .background(.red)
                    //                    Rectangle()
                    //                        .fill(selectedTab == tab ? Color.primary : Color.clear)
                    //                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    //                        .onTapGesture {
                    //                            withAnimation(.easeIn(duration: 0.1)) {
                    //                                selectedTab = tab
                    //                            }
                    //                        }
                    //                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    //                        .contentShape(Rectangle())
                    //                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    //                        .background(.red)
                    //                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                    //                        .foregroundColor(.primary)
                    //                        .font(.system(size: 20))
                    //                        .onTapGesture {
                    //                            withAnimation(.easeIn(duration: 0.1)) {
                    //                                selectedTab = tab
                    //                            }
                    //                        }
                    
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .contentShape(Rectangle())
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .font(.system(size: 20))
                        .background(Color(UIColor.secondarySystemBackground))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.house))
}
