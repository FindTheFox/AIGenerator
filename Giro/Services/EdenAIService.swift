//
//  EdenAIService.swift
//  Giro
//
//  Created by Samuel NEVEU on 31/07/2023.
//

import SwiftUI

enum EndPoint: String {
    case generation
    
    func getURLForEndPoint(_ baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(self.rawValue)
    }
}

class EdenAIService {
    static let shared = EdenAIService()
    
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
//    private let baseURL = URL(string: "https://api.openai.com/v1/images/")!
    private let baseURL = URL(string: "https://api.edenai.run/v2/image/")!
    
    func generateImage(from prompt: String, imageSize: ImageSize) async throws -> [EOpenAIImage] {
        let url = EndPoint.generation.getURLForEndPoint(baseURL)
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(Secret.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let body = EdenAIRequest(resolution: imageSize, providers: "openai", text: prompt)
        let bodyRequest = try? encoder.encode(body)
        request.httpBody = bodyRequest
                
        let (data, _) = try await URLSession.shared.data(for: request)
        let apiResponse = try? JSONDecoder().decode(EdenAIResponse.self, from: data)
        
        return apiResponse?.openai.items.map {
            EOpenAIImage(image: $0.image, image_resource_url: URL(string: $0.image_resource_url))
        } ?? []
    }
    
//    func editImage(from)
}
