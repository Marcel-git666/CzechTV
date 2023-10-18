//
//  NetworkManager.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import Foundation
import XMLCoder

enum NetworkError: Error {
    case invalidData
    case decodingError(Error)
    case networkError(Error)
}

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    @Published var program: Program = Program.init(porad: [])
    
    func fetchData(date: Date, channel: Channels, completion: @escaping (Result<Program, NetworkError>) -> Void) {
        var tvURL = "https://www.ceskatelevize.cz/services-old/programme/xml/schedule.php?user=\(TVAPI.user)"
        var urlDate: String
        var urlChannel: String
        let formatter2: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter
        }()
        
        urlDate = "&date=\(formatter2.string(from: date))"
        urlChannel = "&channel=\(channel)"
        tvURL = tvURL + urlDate + urlChannel
        if let url = URL(string: tvURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decoder = XMLDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(Program.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            task.resume()
        }
    }
}
    
