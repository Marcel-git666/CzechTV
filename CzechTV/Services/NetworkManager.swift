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

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    func dataTaskProtocol(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTaskProtocol(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}


class NetworkManager: ObservableObject {
    
    @Published var program: Program = Program.init(porad: [])
    @Published var error: NetworkError?
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchData(date: Date, channel: Channels, completion: (() -> Void)? = nil) {
        var tvURL = CzechTVAPI.tvURL
        var urlDate: String
        var urlChannel: String
        
        urlDate = "&date=\(date.onlyDate)"
        urlChannel = "&channel=\(channel)"
        tvURL = tvURL + urlDate + urlChannel
        guard let url = URL(string: tvURL) else {
            self.error = .badURL
            return
        }
        let task = self.session.dataTaskProtocol(with: url) { data, response, error in
            print("Inside NetworkManager's data task completion handler.")
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
                print("Caught decoding error: \(decodingError)")
                DispatchQueue.main.async {
                    self.error = .decodingError(decodingError)
                    print("Dispatched error is \(String(describing: decodingError.localizedDescription))")
                    completion?()
                }
            }
        }
        task.resume()
    }
}

