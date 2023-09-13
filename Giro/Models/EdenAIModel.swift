//
//  DallEImageGenerator.swift
//  Giro
//
//  Created by Samuel NEVEU on 24/07/2023.
//

import SwiftUI

/// Request
struct EdenAIRequest: Encodable {
    let resolution: ImageSize
    let providers: String
    let text: String
    let num_images: Int = 2
}

/// Response
struct EdenAIResponse: Decodable {
    let openai: EOpenAIResponse
}
struct EOpenAIResponse: Decodable {
    let status: String
    let items: [EOpenAIImageResponse]
}
struct EOpenAIImageResponse: Decodable {
    let image: String
    let image_resource_url: String
}

/// Model
struct EOpenAIImage {
    let image: String
    let image_resource_url: URL?
}
