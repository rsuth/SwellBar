//
//  DataService.swift
//  SwellBar
//
//  Created by Rick Sutherland on 4/22/24.
//

import Foundation

class DataService {
    static let shared = DataService()  // Singleton instance for simplicity
    private let baseURLString = "https://api.swellbar.app"


    func fetchStationData(stationId: String, completion: @escaping (SwellData?) -> Void) {
        guard let url = URL(string: "\(baseURLString)/swellData/\(stationId)") else {
            debugPrint("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
            }
            if let data = data, error == nil {
                if let decodedResponse = try? JSONDecoder().decode(SwellData.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } else {
                    debugPrint("Failed to decode JSON")
                    completion(nil)
                }
            } else {
                debugPrint("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchStationList(completion: @escaping ([SwellStation]?, Error?) -> Void) {
         let url = URL(string: "\(baseURLString)/stationList")!

         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data, error == nil else {
                 completion(nil, error)
                 return
             }

             do {
                 let stations = try JSONDecoder().decode([SwellStation].self, from: data)
                 completion(stations, nil)
             } catch {
                 completion(nil, error)
             }
         }

         task.resume()
     }
 }
