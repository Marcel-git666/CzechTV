//
//  NetworkManager.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import Foundation
import XMLCoder

let apiKey = ""
let tvURL = "https://www.ceskatelevize.cz/services-old/programme/xml/schedule.php?user=test&date=26.11.2022&channel=ct24"

class NetworkManager: ObservableObject {
    
    
    @Published var program: Program = Program.init(porad: [])
    
    func fetchData() {
        if let url = URL(string: tvURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    
                    if data != nil  {
                        do {
                            
                            let decoder = XMLDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            self.program = try XMLDecoder().decode(Program.self, from: data!)
                                
                        } catch {
                            print(error)
                        }
                        
                    
                    }
                }
            }
            task.resume()
        }
            
    
    }
}

class Parser : NSObject, XMLParserDelegate {
    
    var articleNth = 0
//    func parserDidStartDocument(_ parser: XMLParser) {
//        print("Start of the document")
//        print("Line number: \(parser.lineNumber)")
//    }
//
//    func parserDidEndDocument(_ parser: XMLParser) {
//        print("End of the document")
//        print("Line number: \(parser.lineNumber)")
//    }
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
        
    ) {
        if elementName == "program" && !attributeDict.isEmpty {
            for (attr_key, attr_val) in attributeDict {
                print("Key: \(attr_key), value: \(attr_val)")
            }
        }
        if (elementName=="porad") {
            articleNth += 1
            
            
        } else if (elementName=="nazvy") {
            print("'\(elementName)' in the article element number \(articleNth)")
        }
        
    }

}

