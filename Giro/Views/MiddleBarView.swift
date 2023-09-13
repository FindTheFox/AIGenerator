//
//  MiddleBarView.swift
//  Giro
//
//  Created by Samuel NEVEU on 31/07/2023.
//

import SwiftUI

struct MiddleBarView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var percentage: CGFloat = .zero
    
    var body: some View {
        VStack {
            HStack(spacing: 24) {
                Button(action: {
                    viewModel.isShowingMinusMenu.toggle()
                }, label: {
                    Image("minus-icon")
                        .resizable()
                        .frame(width: 20, height: 16, alignment: .center)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 32, height: 32)
                        )
                })
                
                Spacer()
                
                /// RESET
                Button(action: {
                    viewModel.images = []
                    viewModel.isSaved = false
                }, label: {
                    Image("trash-icon")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .opacity(viewModel.isLoading || viewModel.images.isEmpty ? 0.2 : 1)
                }).disabled(viewModel.images.isEmpty || viewModel.isLoading)
                                
                /// EDIT
//                Button(action: {
//                    withAnimation(.easeOut(duration: 0.8)) {
//                        viewModel.isEditing.toggle()
//                    }
//                }, label: {
//                    Image("pen-icon")
//                        .resizable()
//                        .frame(width: 20, height: 20, alignment: .center)
//                        .foregroundColor(colorScheme == .dark ? .white : .black)
//                        .background(ZStack {
//                            if viewModel.isEditing {
//                                Circle()
//                                    .trim(from: 0, to: percentage)
//                                    .stroke(colorScheme == .dark ? .white : .black, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
//                                    .frame(width: 32, height: 32)
//                                    .animation(.easeOut(duration: 1.0), value: percentage)
//                                    .onAppear {
//                                        self.percentage = 1.0
//                                    }.onDisappear {
//                                        self.percentage = 0.0
//                                    }
//                                }
//                            }
//                        )
//                        .opacity(viewModel.images.isEmpty || viewModel.isLoading ? 0.2 : 1)
//                }).disabled(viewModel.images.isEmpty || viewModel.isLoading)
                
                /// SAVE
                Button(action: {
                    guard let stringData = Data(base64Encoded: viewModel.images[0].b64_json),
                          let uiImage = UIImage(data: stringData) else {
                        print("Error: couldn't create UIImage")
                        return
                    }
                    viewModel.isSaved = true
                    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                }, label: {
                    if !viewModel.isSaved {
                        Image("save-icon")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .opacity(viewModel.isSaved || viewModel.images.isEmpty ? 0.2 : 1)
                    } else {
                        Image("check-icon")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .opacity(viewModel.isSaved || viewModel.images.isEmpty ? 0.2 : 1)
                    }
                })
                .disabled(viewModel.isSaved || viewModel.images.isEmpty || viewModel.isLoading)

                /// SHARE
                Button(action: {
                    if !viewModel.images.isEmpty {
                        let activityController = UIActivityViewController(activityItems: [Data(base64Encoded: viewModel.images[0].b64_json)!] , applicationActivities: nil)
                        print(viewModel.images[0].b64_json)

                        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
                    }
                }, label: {
                    Image("share-icon")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .opacity(viewModel.isLoading || viewModel.images.isEmpty ? 0.2 : 1)
                })
                .disabled(viewModel.isLoading || viewModel.images.isEmpty)

                Spacer()
                
                /// SETTINGS
                Button(action: {
                    viewModel.isShowingPlusMenu.toggle()
                }, label: {
                    Image("plus-icon")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 32, height: 32)
                        )
                })
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(.thinMaterial)
            .cornerRadius(24)
        }
    }
    
    private func getPhotoToShare() -> Data? {
//        if let uiImage = Image(base64Str: viewModel.images[0].b64_json) {
//            return Photo(image: uiImage, caption: "My Chef d'oeuvre")
//        }
//
        if let stringData = Data(base64Encoded: viewModel.images[0].b64_json) {
            return stringData
        }
        return nil
    }
}

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
    public var image: Image
    public var caption: String
}
