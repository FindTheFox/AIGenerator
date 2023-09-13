//
//  HistoryImageStorage.swift
//  Giro
//
//  Created by Samuel NEVEU on 03/08/2023.
//

import Foundation

class HistoryImageStore: ObservableObject {
    @Published var historyImage: [HistoryImage] = []

    func load() async throws {
        let userDefaults = UserDefaults.standard

        if let savedData = userDefaults.object(forKey: "history_images") as? Data {
            do {
                historyImage = try JSONDecoder().decode([HistoryImage].self, from: savedData)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func save(images: [HistoryImage]) async throws {
        do {
            let encodedData = try JSONEncoder().encode(images)

            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: "history_images")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteFromIndex(_ index: Int) async throws {
        do {
            historyImage.remove(at: index)
            let encodedData = try JSONEncoder().encode(historyImage)

            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: "history_images")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
