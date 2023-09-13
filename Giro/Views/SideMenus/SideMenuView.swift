//
//  SideMenuView.swift
//  Giro
//
//  Created by Samuel NEVEU on 31/07/2023.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    var slideEdge: Edge
    
    var content: AnyView

    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.clear
                    .background(.ultraThinMaterial)
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(.move(edge: slideEdge))
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

struct SideMenuView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @Environment(\.colorScheme) var colorScheme

    @Binding var presentSideMenu: Bool
    
    var body: some View {
        if viewModel.isShowingPlusMenu {
            PlusMenuView()
                .ignoresSafeArea(.all)
                .background(.clear)
        } else if viewModel.isShowingMinusMenu {
            MinusMenuView()
            .ignoresSafeArea(.all)
            .background(.clear)
        }

    }
}
