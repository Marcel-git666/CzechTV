//
//  NetworkManager.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import Foundation
import XMLCoder

let user = "gwaihir"


//&date=25.02.2023&channel=ct1

class NetworkManager: ObservableObject {
    
    
    
    @Published var program: Program = Program.init(porad: [])
    
    func fetchData(date: Date, channel: Channels) {
        var tvURL = "https://www.ceskatelevize.cz/services-old/programme/xml/schedule.php?user=\(user)"
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
                if error == nil {
                    
                    if data != nil  {
                        do {
                            
                            let decoder = XMLDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let decodedData = try XMLDecoder().decode(Program.self, from: data!)
                            DispatchQueue.main.async {
                                self.program = decodedData
                                
                            }
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

