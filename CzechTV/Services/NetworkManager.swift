//
//  NetworkManager.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import Foundation
import XMLCoder

enum NetworkError: Error {
    case badURL
    case networkProblem(Error)
    case dataNotFound
    case decodingError(Error)
}

class NetworkManager: ObservableObject {
    
    @Published var program: Program = Program.init(porad: [])
    @Published var error: NetworkError?
    
    func fetchData(date: Date, channel: Channels) {
        var tvURL = CzechTVAPI.tvURL
        var urlDate: String
        var urlChannel: String
        let formatter2: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter
        }()
        
        urlDate = "&date=\(formatter2.string(from: date))"
        print(urlDate)
        print(date.onlyDate)
        urlChannel = "&channel=\(channel)"
        tvURL = tvURL + urlDate + urlChannel
        guard let url = URL(string: tvURL) else {
            self.error = .badURL
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.error = .networkProblem(error)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.error = .dataNotFound
                }
                return
            }
            do {
                let decoder = XMLDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try XMLDecoder().decode(Program.self, from: data)
                DispatchQueue.main.async {
                    self.program = decodedData
                }
            } catch let decodingError {
                DispatchQueue.main.async {
                    self.error = .decodingError(decodingError)
                }
            }
        }
        task.resume()
    }
}

