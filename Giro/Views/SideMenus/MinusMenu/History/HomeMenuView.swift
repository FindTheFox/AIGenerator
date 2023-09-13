//
//  HomeMenuView.swift
//  Giro
//
//  Created by Samuel NEVEU on 19/08/2023.
//

import SwiftUI

struct HomeMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selectedTabIndex: NavigationMenu
        
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            Text("home").lgcTextLight24()
            
            Divider().overlay(colorScheme == .dark ? .white : .black)
            
            Button(action: {
                withAnimation(.easeOut) {
                    selectedTabIndex = .history
                }
            }, label: {
                HStack {
                    Text("History")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .lgcTextBold16()
                    Spacer()
                    Image("right-icon")
                        .resizable()
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .frame(width: 12, height: 12, alignment: .trailing)
                }.padding(16)
            })
            
            Spacer()
        }
        .padding(.top, 70)
        .padding(.horizontal, 16)
        .frame(width: 270)
    }
}
