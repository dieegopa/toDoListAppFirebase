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
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(.primary)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.house))
}
