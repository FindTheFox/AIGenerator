//
//  HistoryImagesCard.swift
//  Giro
//
//  Created by Samuel NEVEU on 19/08/2023.
//

import SwiftUI

struct HistoryImagesCard: View {
    @Environment(\.colorScheme) var colorScheme

    let image64: String
    let prompt: String
    
    @Binding var selectedImages: Int?
    @Binding var openFullscreen: Bool
    let index: Int

    var body: some View {
        ZStack {
            Image(base64Str: image64)?
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .if(selectedImages == index) { view in
            view.overlay {
                ZStack {
                    Color.clear.background(.thickMaterial.opacity(0.8))
                    VStack {
                        Text(prompt)
                            .lgcTextBold16()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        Divider().overlay(colorScheme == .dark ? .white : .black)
                        ImageOverlayOption(openFullscreen: $openFullscreen, index: index)
                    }
                    .padding(16)
                }

            }
        }
        .cornerRadius(8)
    }
}

private struct ImageOverlayOption: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @Environment(\.colorScheme) var colorScheme

    @Binding var openFullscreen: Bool
    
    var index: Int
    
    var body: some View {
        HStack(spacing: 24) {
            Button(action: {
                viewModel.deleteHistoryImagesFromIndex(index: index)
            }, label: {
                Image("trash-icon")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            })
            
            Spacer()
            
            Button(action: {
                guard let stringData = Data(base64Encoded: viewModel.getHistoryImages()[index].b64_json),
                      let uiImage = UIImage(data: stringData) else {
                    print("Error: couldn't create UIImage")
                    return
                }
                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            }, label: {
                if !viewModel.isSaved {
                    Image("save-icon")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                } else {
                    Image("check-icon")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            })
            
            Button(action: {
                openFullscreen.toggle()
            }, label: {
                Image("fullscreen-icon")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            })
        }
    }
}
