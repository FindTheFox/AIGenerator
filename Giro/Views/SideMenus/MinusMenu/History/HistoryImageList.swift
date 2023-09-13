//
//  HistoryImageList.swift
//  Giro
//
//  Created by Samuel NEVEU on 19/08/2023.
//

import SwiftUI

struct HistoryImagesList: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @StateObject var imagesStore = HistoryImageStore()
    var images: [HistoryImage]
    
    @State var selectedImages: Int?
    @State var openFullscreen: Bool = false
    
    @Namespace private var animationHistory
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(Array(viewModel.imagesStore.historyImage.enumerated()), id: \.offset) { index, image in
                    HistoryImagesCard(
                        image64: image.b64_json,
                        prompt: image.prompt,
                        selectedImages: $selectedImages,
                        openFullscreen: $openFullscreen,
                        index: index
                    ).onTapGesture {
                        selectedImages = selectedImages != index ? index : nil
                        print("ONTAP \(index) \(selectedImages)")
                    }
                    .imageFullScreenCover(show: $openFullscreen) {
                        FullScreenImageView(
                            index: $viewModel.currentIndex,
                            isShow: $openFullscreen,
                            images: viewModel.getHistoryImages().map {
                                B64Image(from: $0)
                            },
                            animationID: animationHistory
                        )
                    }
                }
            }.padding(.top, 16)
        }
    }
}
