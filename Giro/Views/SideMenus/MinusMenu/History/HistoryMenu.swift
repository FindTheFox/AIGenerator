//
//  HistoryView.swift
//  Giro
//
//  Created by Samuel NEVEU on 19/08/2023.
//

import SwiftUI

struct HistoryMenuView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @Environment(\.colorScheme) var colorScheme

    var changePage: (NavigationMenu) -> Void
    
    @State private var opacity: Double = 0.0
    @State private var scollOpacity: Double = 0.0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Text("History").lgcTextLight24()
            }
            .frame(maxWidth: .infinity)
            .overlay(
                ZStack {
                    Image("left-icon")
                        .resizable()
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .frame(width: 12, height: 12)
                }
                .frame(width: 48, height: 48)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) {
                        opacity = 0
                    }
                    withAnimation(.linear(duration: 0.01).delay(0.01)) {
                        scollOpacity = 0
                    }
                    changePage(.home)
                },
                alignment: .leading
            )
            .padding(.bottom, 16)
            
            Divider().overlay(colorScheme == .dark ? .white : .black)
            
            HistoryImagesList(images: viewModel.getHistoryImages())
                .opacity(scollOpacity)
            
            Spacer()
        }
        .padding(.top, 70)
        .padding(.horizontal, 16)
        .frame(width: 270)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.9)) {
                opacity = 1
            }
            withAnimation(.linear(duration: 0.2).delay(0.2)) {
                scollOpacity = 1
            }
        }
        .clipped()
    }
}
