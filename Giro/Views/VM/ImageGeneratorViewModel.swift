//
//  ImageGeneratorViewModel.swift
//  Giro
//
//  Created by Samuel NEVEU on 24/07/2023.
//

import Foundation

class ImageGeneratorViewModel: ObservableObject {
//    @Published var images: [OpenAIImage?] = []
//    @Published var images: [String] = []
    @Published var images: [B64Image] = []
    @Published var historyImg: [HistoryImage] = []
    @Published var imageRes: ImageSize = .small

    @Published var isLoading = false
    @Published var isSaved = false

    @Published var isShowingPlusMenu: Bool = false
    @Published var isShowingMinusMenu: Bool = false
    @Published var isEditing: Bool = false

    @Published var textPrompt: String = ""
    @Published var currentIndex: Int?

    @Published var imagesStore = HistoryImageStore()
    
    private let edenAIService = EdenAIService.shared
    private let sdService = SDService.shared
    private let openAIService = OpenAIService.shared
    
    func getImagesFromGenerate(_ prompt: String, imageSize: ImageSize) {
        isLoading = true
        Task {
//            let images = try? await edenAIService.generateImage(from: prompt, imageSize: imageSize)
//            let data = try? await sdService.generateImage(from: prompt)
            let data = try? await openAIService.generateImage(from: prompt, imageRes: imageRes)

            DispatchQueue.main.async { [self] in
                images = data ?? []
                isLoading = false
                
                if data != nil {
                    let imagesToSave = images.map { image in
                        HistoryImage(id: UUID(), base64_img: image.b64_json, prompt: prompt)}

                    saveHistoryImages(images: imagesToSave)
                }
            }
        }
    }
    
    func getImagesFromEditing(_ prompt: String, base64 image: String) {
        isLoading = true
        Task {
            let data = try? await openAIService.editImage(from: prompt, base64: image)

            DispatchQueue.main.async { [self] in
                images = data ?? []
                print(images)
                isLoading = false

                if data != nil {
                    let imagesToSave = images.map { image in
                        HistoryImage(id: UUID(), base64_img: image.b64_json, prompt: prompt)}
                    saveHistoryImages(images: imagesToSave)
                }
            }
        }
    }
    
    func loadHistoryImages() {
        Task {
            do {
                try await self.imagesStore.load()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func saveHistoryImages(images: [HistoryImage]) {
        Task {
            do {
                let newImages = getHistoryImages() + images
                try await self.imagesStore.save(images: newImages)
                loadHistoryImages()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func deleteHistoryImagesFromIndex(index: Int) {
        Task {
            try await imagesStore.deleteFromIndex(index)
        }
        loadHistoryImages()
    }
    
    func getHistoryImages() -> [HistoryImage] {
        return imagesStore.historyImage
    }
}
