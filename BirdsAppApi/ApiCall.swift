//
//  ApiCall.swift
//  BirdsAppApi
//
//  Created by Jakub Patelski on 12/03/2023.
//

import Foundation

struct Bird: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: URL
    let wikipediaUrl: String
}

class BirdData: ObservableObject {
    @Published var birds = [Bird]()
    
    init() {
        // Make the API call
        guard let url = URL(string: "http://localhost:8080/birds") else {
            return
            
        }
        URLSession.shared.dataTask(with: url) {
            data, _, error in
            
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode the JSON data
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([Bird].self, from: data)
                
                // Store the data
                DispatchQueue.main.async {
                    self.birds = result
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
