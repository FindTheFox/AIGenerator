//
//  ContentView.swift
//  Giro
//
//  Created by Samuel NEVEU on 24/07/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            AngularGradient(colors: colorScheme == .dark ? [.cyan, .purple, .white] : [.purple, .cyan, .black], center: .zero)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                ImageContainerView()

                Spacer()

                CommandeView()
            }
            SideMenu(
                isShowing: $viewModel.isShowingPlusMenu,
                slideEdge: .trailing,
                content: AnyView(SideMenuView(presentSideMenu: $viewModel.isShowingPlusMenu))
            )
            SideMenu(
                isShowing: $viewModel.isShowingMinusMenu,
                slideEdge: .leading,
                content: AnyView(SideMenuView(presentSideMenu: $viewModel.isShowingMinusMenu))
            )
        }
        .environmentObject(viewModel)
        .ignoresSafeArea(.all)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct ImageContainerView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var manager = MotionManager()

    @State private var fullScreenViewer: Bool = false
    
    @Namespace private var animation
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.clear.blendMode(.overlay)
            if viewModel.isLoading {
                ProgressView().tint(colorScheme == .dark ? .black : .white)
            }
        }
        .overlay {
            ZStack {
                if !viewModel.isLoading && !viewModel.images.isEmpty {
                    ForEach(Array(viewModel.images.enumerated()), id: \.offset) { index, image in
                        if !fullScreenViewer {
                            Image(base64Str: image.b64_json)?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(.top, 42)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 1, dampingFraction: 1.2, blendDuration: 1.2)) {
                                        fullScreenViewer.toggle()
                                    }
                                    viewModel.currentIndex = index
                                }
                                .matchedGeometryEffect(id: "image_" + String(index), in: animation)
                                .modifier(ParallaxMotionModifier(manager: manager, magnitude: 28))
                                
                        }
                    }
                }
            }.imageFullScreenCover(show: $fullScreenViewer) {
                FullScreenImageView(
                    index: $viewModel.currentIndex,
                    isShow: $fullScreenViewer,
                    images: viewModel.images,
                    animationID: animation
                )
            }
        }
        .frame(maxHeight: 500)
//        .edgesIgnoringSafeArea(.top)
    }
}
