//
//  StableDiffusionService.swift
//  Giro
//
//  Created by Samuel NEVEU on 30/07/2023.
//

import SwiftUI

enum SDEndPoint: String {
    case txt2img
    
    func getURLForEndPoint(_ baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(self.rawValue)
    }
}
 
class SDService {
    static let shared = SDService()
    
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
    private let baseURL = URL(string: "https://0cb3-2001-861-5dd0-c620-f1eb-1526-da75-fa49.ngrok-free.app/sdapi/v1/")!
    
    func generateImage(from prompt: String) async throws -> [String] {
        let url = SDEndPoint.txt2img.getURLForEndPoint(baseURL)
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let body = SDTextToImageRequest(prompt: prompt)
        let bodyRequest = try? encoder.encode(body)
        request.httpBody = bodyRequest
                
        let (data, _) = try await URLSession.shared.data(for: request)
        let apiResponse = try? JSONDecoder().decode(TextToImageResponseDto.self, from: data)
        
        return apiResponse?.images ?? []
    }
}
