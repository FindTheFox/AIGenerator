//
//  SideMinusMenuView.swift
//  Giro
//
//  Created by Samuel NEVEU on 03/08/2023.
//

import SwiftUI

enum NavigationMenu: Int, CaseIterable, Identifiable {
    var id: Self { self }

    case home
    case history
    
    var tag: Int {
        switch self {
        case .home: return 0
        case .history: return 1
        }
    }
}

struct MinusMenuView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State private var navIndex: NavigationMenu = .home
    
    var body: some View {
        HStack {
            ZStack{
                if navIndex == .home {
                    HomeMenuView(selectedTabIndex: $navIndex)
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut, value: navIndex == .home)
                }
               
                if navIndex == .history {
                    HistoryMenuView(changePage: self.changePageAnimated)
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut, value: navIndex == .history)
                }
                
            }.background(
                Rectangle()
                .fill(.thinMaterial)
                .frame(width: 270)
                .cornerRadius(24)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 3)
            )
            Spacer()
        }
    }
    
    func changePageAnimated(destination: NavigationMenu) {
        withAnimation(.easeOut(duration: 0.3)) {
            navIndex = destination
        }
    }
}
