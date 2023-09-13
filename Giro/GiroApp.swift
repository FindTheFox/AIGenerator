//
//  GiroApp.swift
//  Giro
//
//  Created by Samuel NEVEU on 24/07/2023.
//

import SwiftUI

@main
struct GiroApp: App {
    @StateObject var viewModel = ImageGeneratorViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    viewModel.loadHistoryImages()
                }
                .environmentObject(viewModel)
        }
    }
}
