//
//  CommandeView.swift
//  Giro
//
//  Created by Samuel NEVEU on 25/07/2023.
//

import SwiftUI

struct CommandeView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @FocusState var isKeyboardOpen: Bool
        
    var body: some View {
        VStack(spacing: 16) {
            if !isKeyboardOpen {
                MiddleBarView()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if isKeyboardOpen {
                    Button(action: {
                        isKeyboardOpen = false
                    }, label: {
                        Image("bottom-icon")
                            .resizable()
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .frame(width: 24, height: 12)
                    })
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                VStack {
                    TextField("Prompt", text: $viewModel.textPrompt, prompt: Text("Imagine ..."), axis: .vertical)
                        .textFieldStyle(.plain)
                        .submitLabel(.continue)
                        .frame(minHeight: 32, maxHeight: .infinity)
                        .padding(.horizontal, 16)
                        .focused($isKeyboardOpen)
                }
                .frame(maxHeight: .infinity)

                Divider().overlay(colorScheme == .dark ? .white : .black)
                    .opacity(0.8)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                
                Button(action: {
                    viewModel.textPrompt = ""
                }, label: {
                    Text("Reset")
                        .lgcTextBold12()
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .opacity(0.8)
                }).frame(maxWidth: .infinity)
                    .padding(.bottom, 8)
                
            }
            .frame(maxHeight: .infinity)
            .background(.thinMaterial)
            .cornerRadius(16)
            .onTapGesture {
                isKeyboardOpen.toggle()
            }
                        
            if !isKeyboardOpen {
                HStack {
                    if viewModel.isEditing {
                        Button(action: {
                            if !viewModel.images.isEmpty {
                                viewModel.getImagesFromEditing(viewModel.textPrompt, base64: viewModel.images[0].b64_json)
                            }
                            viewModel.isSaved = false
                        }, label: {
                            Text("Edit")
                                .lgcTextBold16()
                                .padding()
                        })
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, maxHeight: 28)
                        //                    .transition(.move(edge: .trailing))
                        
                        Divider().overlay(colorScheme == .dark ? .white : .black).padding(16)
                    }
                    
                    Button(action: {
                        viewModel.getImagesFromGenerate(viewModel.textPrompt, imageSize: viewModel.imageRes)
                        viewModel.isSaved = false
                    }, label: {
                        Text("Generate")
                            .lgcTextBold16()
                            .padding()
                            .transition(.move(edge: .leading))
                    })
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .leading))
                }
                .frame(height: 48)
                .background(RoundedRectangle(cornerRadius: 32)
                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                )
                
                Spacer()
            }
        }
        .frame(minHeight: 0, maxHeight: 288)
        .padding(16)
        .background(.thinMaterial)
        .cornerRadius(16)
        .keyboardAdaptive()
    }
}
