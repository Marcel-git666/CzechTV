//
//  NetworkManagerTests.swift
//  CzechTVTests
//
//  Created by Marcel Mravec on 20.10.2023.
//

import XCTest
import XMLCoder
@testable import CzechTV

class NetworkManagerTests: XCTestCase {

    var sut: NetworkManager!
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = NetworkManager(session: mockSession)
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testParseMockProgram() {
        // 1. Get the URL for MockProgram.xml from the test bundle
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockProgram", withExtension: "xml") else {
            XCTFail("Missing file: MockProgram.xml")
            return
        }

        // 2. Load the XML data
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Unable to load XML data from MockProgram.xml")
            return
        }

        // 3. Parse the XML data
        let decoder = XMLDecoder()
        do {
            let decodedData = try decoder.decode(Program.self, from: data)
            // Now use decodedData to run your tests
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    
    func testFetchData_Success() {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockProgram", withExtension: "xml") else {
            XCTFail("Missing file: MockProgram.xml")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Unable to load XML data from MockProgram.xml")
            return
        }
        let mockData = data // ... provide some mock XML data here
        mockSession.data = mockData
        
        sut.fetchData(date: Date(), channel: .ct1)
        
        XCTAssertNotNil(sut.program)
        XCTAssertNil(sut.error)
    }
    
    func testFetchData_DecodingError() {
        // Create an expectation for a background task.
        let expectation = XCTestExpectation(description: "Decode data")

        // Set up mock data and session
        let mockData = Data("Invalid XML".utf8)
        mockSession.data = mockData

        // Inject the mock session into the SUT (System Under Test)
        sut = NetworkManager(session: mockSession)

        // Fetch data and wait for the asynchronous process to complete
        sut.fetchData(date: Date(), channel: .ct1) {
            // Asserts
            XCTAssertNotNil(self.sut.error)
            if case .decodingError = self.sut.error {
                print(self.sut.error?.localizedDescription)
            } else {
                XCTFail("Expected decoding error")
            }
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 10.0)
    }

    
    // Add more tests for other error scenarios...
}
