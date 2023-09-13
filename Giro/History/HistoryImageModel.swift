//
//  HistoryImageModel.swift
//  Giro
//
//  Created by Samuel NEVEU on 03/08/2023.
//

import Foundation

struct HistoryImage: Identifiable, Codable {
    let id: UUID
    let date: Date
    let b64_json: String
    let prompt: String
    
    init(id: UUID, date: Date = Date(), base64_img: String, prompt: String) {
        self.id = id
        self.date = date
        self.b64_json = base64_img
        self.prompt = prompt
    }
}
