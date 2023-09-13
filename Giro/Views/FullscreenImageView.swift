//
//  FullscreenImageView.swift
//  Giro
//
//  Created by Samuel NEVEU on 25/07/2023.
//

import SwiftUI

struct FullScreenImageView: View {
    @Binding var index: Int?
    @Binding var isShow: Bool
    let images: [B64Image]
    var url: URL?
    
    var animationID: Namespace.ID
    
    @Environment(\.dismiss) private var dismiss
    @State private var animateBaseImage: Bool = false
    @State private var animateFullImage: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                if isShow && index != nil {
                    Image(base64Str: images[index!].b64_json)?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "image_" + String(index!), in: animationID)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(x: 10, y: 10)))
                    
                }
            }
            .clipped()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(.ultraThinMaterial.opacity(animateBaseImage ? 1 : 0))
        .overlay(alignment: .topLeading) {
            Button(action: {
                withAnimation(.interactiveSpring(response: 1, dampingFraction: 1.2, blendDuration: 1.2)) {
                    animateBaseImage = false
                    animateFullImage = false
                    dismiss()
                }
                index = nil
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.black)
            })
            .padding(EdgeInsets(top: 56, leading: 24, bottom: 0, trailing: 0))
        }
        .onAppear {
            withAnimation(.interactiveSpring(response: 1, dampingFraction: 1.2, blendDuration: 1.2)) {
                animateBaseImage = true
                animateFullImage = true
            }
        }
        .ignoresSafeArea(.all)
    }
}
