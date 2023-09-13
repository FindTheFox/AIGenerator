//
//  OpenAIModel.swift
//  Giro
//
//  Created by Samuel NEVEU on 31/07/2023.
//

import SwiftUI

/// Request
struct TextToImageRequest: Encodable {
    let prompt: String
    let n: Int = 1
    let size: String
    let response_format: String = "b64_json"
}

struct ImageToImageRequest: Encodable {
    let prompt: String
    let image: Data
    let n: Int = 1
    let size: String = "256x256"
    let response_format: String = "b64_json"
}

enum ImageSize: String, Encodable, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    
    case small
    case medium
    case large
    
    var description: String {
        switch self {
        case .small: return "256x256"
        case .medium: return "512x512"
        case .large: return "1024x1024"
        }
    }
}

enum ImageFormat: String, Encodable {
    case url = "url"
    case b64 = "b64_json"
    
    var description: String {
        switch self {
        case .url: return "url"
        case .b64: return "b64_json"
        }
    }
}


/// Response

struct OpenAIDto: Decodable {
    let created: Int
    let data: [B64ImageDto]
    
    enum CodingKeys: String, CodingKey {
        case created,
        data
    }
}

struct URLImageDto: Decodable {
    let url : String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

struct B64ImageDto: Decodable {
    let b64_json: String
    
    enum CodingKeys: String, CodingKey {
        case b64_json
    }
}

struct URLImage {
    let url : String
    
    init(from dto: URLImageDto) {
        self.url = dto.url
    }
}

struct B64Image {
    let id: UUID
    let date: Date
    let b64_json: String
    let prompt: String

    init(from dto: B64ImageDto) {
        self.b64_json = dto.b64_json
        prompt = ""
        id = UUID()
        date = Date()
    }
    
    init(from dto: HistoryImage) {
        b64_json = dto.b64_json
        prompt = dto.prompt
        id = dto.id
        date = dto.date
    }
}
