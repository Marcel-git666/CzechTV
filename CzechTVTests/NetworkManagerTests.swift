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
    let mockProgramXMLFileName = "MockProgram.xml"

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
    
    func getMockProgramData() -> Data? {
        if let url = Bundle(for: type(of: self)).url(forResource: "MockProgram", withExtension: "xml"),
           let data = try? Data(contentsOf: url) {
            return data
        }
        XCTFail("Failed to get mock data from \(mockProgramXMLFileName)")
        return nil
    }
    
    func testParseMockProgram() {
        guard let data = getMockProgramData() else { return }

        do {
            let decodedData = try XMLDecoder().decode(Program.self, from: data)
            XCTAssertEqual(decodedData.porad.first?.nazvy.nazev, "Studio 6")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func testFetchData_Success() {
        guard let mockData = getMockProgramData() else { return }
        mockSession.data = mockData

        sut.fetchData(date: Date(), channel: .ct1)
        
        XCTAssertNotNil(sut.program)
        XCTAssertNil(sut.error)
    }
    
    func testFetchData_DecodingError() {
        let expectation = XCTestExpectation(description: "Decode data")
        
        mockSession.data = Data("Invalid XML".utf8)
        
        sut.fetchData(date: Date(), channel: .ct1) {
            XCTAssertNotNil(self.sut.error)
            if case .decodingError = self.sut.error {
                print(self.sut.error?.localizedDescription ?? "Unknown error")
            } else {
                XCTFail("Expected decoding error")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

}

