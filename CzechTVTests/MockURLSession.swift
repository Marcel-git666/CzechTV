//
//  MockURLSession.swift
//  CzechTVTests
//
//  Created by Marcel Mravec on 20.10.2023.
//

import Foundation
@testable import CzechTV

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        print("Resuming mock data task.")
        closure()
    }
}


class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?

    func dataTaskProtocol(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        print("Creating mock data task.")
        return MockURLSessionDataTask {
            print("Executing completion handler of mock data task.")
            completionHandler(self.data, nil, self.error)
        }
    }
}


