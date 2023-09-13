//
//  SidePlusMenuView.swift
//  Giro
//
//  Created by Samuel NEVEU on 03/08/2023.
//

import SwiftUI

struct PlusMenuView: View {
    @EnvironmentObject var viewModel: ImageGeneratorViewModel
            
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Spacer()

            ZStack{
                VStack(alignment: .center, spacing: 16) {
                    Text("Settings")
                        .lgcTextLight24()
                    
                    Divider().overlay(colorScheme == .dark ? .white : .black)
                    
                    Picker(selection: $viewModel.imageRes, label: Text("Resolution")) {
                        ForEach(ImageSize.allCases, id: \.self) { res in
                            Text(res.description)
                                .padding()
                                .lgcTextBold12()
                                .tag(res.description)
                        }
                    }
                    .tint(colorScheme == .dark ? .white : .black)
                    .pickerStyle(.segmented)
                    
                    Spacer()
                }
                .padding(.top, 70)
                .padding(.horizontal, 16)
                .frame(width: 270)
            }.background(
                Rectangle()
                .fill(.thinMaterial)
                .frame(width: 270)
                .cornerRadius(24)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 3)
            )
        }
    }
}
