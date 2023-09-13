//
//  OpenAIService.swift
//  Giro
//
//  Created by Samuel NEVEU on 31/07/2023.
//

import SwiftUI
import Foundation
import Alamofire

func downloadImage(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        completion(data, nil)
    }
    task.resume()
}

enum OpenAIEndPoint: String {
    case generations
    case edits
    
    func getURLForEndPoint(_ baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(self.rawValue)
    }
}
 
class OpenAIService {
    static let shared = OpenAIService()
    
//    var cancellables = Set<AnyCancellable>()
    
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
    
    private let baseURL = URL(string: "https://api.openai.com/v1/images/")!
    
    func generateImage(from prompt: String, imageRes: ImageSize) async throws -> [B64Image] {
        let url = OpenAIEndPoint.generations.getURLForEndPoint(baseURL)
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Secret.openApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = TextToImageRequest(prompt: prompt, size: imageRes.description)
        let bodyRequest = try? encoder.encode(body)
        request.httpBody = bodyRequest
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let apiResponse = try? JSONDecoder().decode(OpenAIDto.self, from: data)

            return apiResponse?.data.map {
                B64Image(from: $0)
            } ?? []

        } catch {
            print(error)
        }
        return []
    }
    
    func editImage(from prompt: String, base64 imageBase64: String) async throws -> [B64Image] {
        print("test")
        
        let url = OpenAIEndPoint.edits.getURLForEndPoint(baseURL)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Secret.openApiKey)"
        ]
        
        let parameters: Parameters = [
            "image": imageBase64,
            "mask": imageBase64,
            "prompt": prompt,
            "n": "1",
            "size": "256x256"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = (value as? String)?.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: url, headers: headers)
        .validate()
        .responseDecodable(of: OpenAIDto.self) { response in
            switch response.result {
            case .success(let result):
                print("Response: \(result)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        /*
         var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
         request.httpMethod = "POST"
         request.addValue("Bearer \(Secret.openApiKey)", forHTTPHeaderField: "Authorization")
         //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         print("wtf ")
         
         let boundary = generateBoundary()
         request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
         
         guard let stringImgData = Data(base64Encoded: image),
         let imageData = UIImage(data: stringImgData) else {
         print("Error: couldn't create UIImage")
         return []
         }
         guard let stringMskData = Data(base64Encoded: image),
         let maskData = UIImage(data: stringMskData) else {
         print("Error: couldn't create UIImage")
         return []
         }
         
         print("wtf ")
         var bodyData = Data()
         bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
         bodyData.append("Content-Disposition: form-data; name=\"image\"\r\n\r\n".data(using: .utf8)!)
         bodyData.append(imageData.pngData()!)
         
         bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         bodyData.append("Content-Disposition: form-data; name=\"mask\"\r\n\r\n".data(using: .utf8)!)
         bodyData.append(maskData.pngData()!)
         
         bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         bodyData.append("Content-Disposition: form-data; name=\"prompt\"\r\n\r\n".data(using: .utf8)!)
         bodyData.append(prompt.data(using: .utf8)!)
         
         bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         bodyData.append("Content-Disposition: form-data; name=\"n\"\r\n\r\n".data(using: .utf8)!)
         bodyData.append("1".data(using: .utf8)!)
         
         bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         bodyData.append("Content-Disposition: form-data; name=\"size\"\r\n\r\n".data(using: .utf8)!)
         bodyData.append("256x256".data(using: .utf8)!)
         
         bodyData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
         
         request.httpBody = bodyData
         
         print("wtf ")
         
         URLSession.shared.dataTaskPublisher(for: request)
         .tryMap { data, response -> Data in
         guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
         throw URLError(.badServerResponse)
         }
         print(data)
         return data
         }
         .decode(type: OpenAIDto.self, decoder: JSONDecoder())
         .receive(on: DispatchQueue.main)
         .sink(receiveCompletion: { completion in
         switch completion {
         case .finished:
         break
         case .failure(let error):
         print("Erreur lors de la requête : \(error)")
         }
         }, receiveValue: { response in
         // Traiter la réponse ici (response contient les informations de la réponse de l'API)
         print(response)
         })
         .store(in: &cancellables)
         */
        /*
         let boundary = generateBoundary()
         request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
         
         let dataBody = createDataBody(media: mediaImage, boundary: boundary)
         
         let body = ImageToImageRequest(prompt: prompt, image: image)
         let bodyRequest = try? encoder.encode(body)
         request.httpBody = bodyRequest
         
         print(body)
         do {
         let (data, _) = try await URLSession.shared.data(for: request)
         let apiResponse = try? JSONDecoder().decode(OpenAIDto.self, from: data)
         
         return apiResponse?.data.map {
         B64Image(from: $0)
         } ?? []
         } catch {
         print(error)
         }
         */
        return []
    }
}



enum ImageExt
{
    case png
    case jpeg(CGFloat)
}

extension UIImage
{
  func imageToString(_ format: ImageExt) -> String?
  {
        var imageData: Data?
        
        switch format
        {
          case .png:
            imageData = self.pngData()
          case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
  }
}

func stringToImage(imageBase64String: String) -> UIImage {
    let imageData = Data(base64Encoded: imageBase64String)
    let image = UIImage(data: imageData!)
    return image!
}

func createMultipartFormData(parameters: [String: String], boundary: String) -> Data {
    var body = Data()
    for (key, value) in parameters {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.append("\(value)\r\n")
    }
    body.append("--\(boundary)--\r\n")
    return body
}


func generateBoundary() -> String { return "Boundary-\(NSUUID().uuidString)" }

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/png"
        self.filename = "imagefile.png"
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
            print("data======>>>",data)
        }
    }
}
