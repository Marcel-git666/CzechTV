//
//  Program.swift
//  CzechTV
//
//  Created by Marcel Mravec on 23.02.2023.
//

import Foundation

struct Program: Codable {
    let porad: [Porad]
}

struct Porad: Codable, Hashable {
    
    let linky: Linky
    let vps: String
    let datum: String
    let cas: String
    let nazvy: Nazvy
    let dil: String?
    let zanr: String
    let stopaz: String
    let noticka: String?
    let regionalni: String
    let alternativa: String
    let ikonky: Ikonky
    let obrazky: Obrazky
    let dostupnost: Dostupnost
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(vps)
    }
    static let example = Porad(linky: Linky.example, vps: "11223344", datum: "01.01.2023", cas: "06:00", nazvy: Nazvy.example, dil: "", zanr: "sci-fi", stopaz: "", noticka: "Popisek pořadu", regionalni: "CZ", alternativa: "není", ikonky: Ikonky.example, obrazky: Obrazky.example, dostupnost: Dostupnost.example)
    
}

struct Linky: Codable, Equatable {
    let program: String
    let ivysilani: String
    static let example = Linky(program: "https://google.com", ivysilani: "https://ivysilani.cz")
}

struct Nazvy: Codable, Equatable {
    let nadtitul: String?
    let nazev: String
    let original: String?
    let nazev_casti: String?
    static let example = Nazvy(nadtitul: "", nazev: "Název pořadu", original: "Show title", nazev_casti: "Part 1")
}

struct Ikonky: Equatable {
    let zvuk: String
    let ad: Int
    let skryte_titulky: String
    let neslysici: Int
    let live: Int
    let premiera: Int
    let cb: Int
    let hvezdicka: Int
    let labeling: String
    let puvodni_zneni: Int?
    let pomer: String
    let hd: Int
    init(zvuk: String, ad: Int, skryte_titulky: String, neslysici: Int, live: Int, premiera: Int, cb: Int, hvezdicka: Int, labeling: String, puvodni_zneni: Int?, pomer: String, hd: Int) {
        self.zvuk = zvuk
        self.ad = ad
        self.skryte_titulky = skryte_titulky
        self.neslysici = neslysici
        self.live = live
        self.premiera = premiera
        self.cb = cb
        self.hvezdicka = hvezdicka
        self.labeling = labeling
        self.puvodni_zneni = puvodni_zneni
        self.pomer = pomer
        self.hd = hd
    }

    static let example = Ikonky(zvuk: "S", ad: 0, skryte_titulky: "1", neslysici: 0, live: 0, premiera: 1, cb: 0, hvezdicka: 1, labeling: "1", puvodni_zneni: 1, pomer: "4:3", hd: 1)
    
    private enum CodingKeys:String, CodingKey {
        case zvuk
        case ad
        case skryte_titulky
        case neslysici
        case live
        case premiera
        case cb
        case hvezdicka
        case labeling
        case puvodni_zneni
        case pomer
        case hd
    }
    
    
}
extension Ikonky: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        zvuk = try container.decode(String.self, forKey: .zvuk)
        ad = try container.decode(Int.self, forKey: .ad)
        skryte_titulky = try container.decodeIfPresent(String.self, forKey: .skryte_titulky) ?? "0"
        neslysici = try container.decode(Int.self, forKey: .neslysici)
        live = try container.decode(Int.self, forKey: .live)
        premiera = try container.decode(Int.self, forKey: .premiera)
        cb = try container.decode(Int.self, forKey: .cb)
        hvezdicka = try container.decode(Int.self, forKey: .hvezdicka)
        labeling = try container.decode(String.self, forKey: .labeling)
        puvodni_zneni = try container.decodeIfPresent(Int.self, forKey: .puvodni_zneni) ?? 0
        pomer = try container.decode(String.self, forKey: .pomer)
        hd = try container.decode(Int.self, forKey: .hd)
    }
}

struct Dostupnost: Codable, Equatable {
    let stav: String
    let od: String
    let `do`: String
    static let example = Dostupnost(stav: "stav", od: "from", do: "do")
}

struct Obrazky: Equatable {
    let tv_program: String?
    let nahled: String
    init(tv_program: String, nahled: String) {
        self.tv_program = tv_program
        self.nahled = nahled
    }
    static let example = Obrazky(tv_program: "", nahled: "")
    
    enum CodingKeys: String, CodingKey {
        case tv_program
        case nahled
    }
}

extension Obrazky: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            tv_program = try container.decode(String.self, forKey: .tv_program)
        } catch {
            print("Decoding error for tv_program at path \(container.codingPath): \(error)")
            tv_program = "Default Value"
        }
        
        nahled = try container.decode(String.self, forKey: .nahled)
    }
}

enum Channels: String, Identifiable, CaseIterable {
    
    case ct1 = "ČT1"
    case ct2 = "ČT2"
    case ct24 = "ČT24"
    case ct4 = "ČT sport"
    case ct5 = "ČT :D"
    case ct6 = "ČT art"
    case ct7 = "ČT3"
    var id: Channels { self }
}
