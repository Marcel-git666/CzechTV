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
    @Published var program: Program = Program(porad: [])
    
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
        print("Fetching data from URL: \(tvURL)")
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
                print(String(data: data, encoding: .utf8) ?? "Invalid data")
                do {
                    let decoder = XMLDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(Program.self, from: data)
                    DispatchQueue.main.async { 
                        self.program = decodedData
                    }
                    completion(.success(decodedData))
                } catch let error as DecodingError {
                    switch error {
                    case .dataCorrupted(let context),
                         .keyNotFound(_, let context),
                         .typeMismatch(_, let context),
                         .valueNotFound(_, let context):
                        print(context.debugDescription)
                        print(context.codingPath)
                    default:
                        print(error.localizedDescription)
                    }
                    completion(.failure(.decodingError(error)))
                }
                catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            task.resume()
        }
    }
}
    
