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

struct Ikonky: Codable, Equatable {
    let zvuk: String
    let ad: Int
    let skryte_titulky: Int
    let neslysici: Int
    let live: Int
    let premiera: Int
    let cb: Int
    let hvezdicka: Int
    let labeling: String
    let puvodni_zneni: Int
    let pomer: String
    let hd: Int
    static let example = Ikonky(zvuk: "S", ad: 0, skryte_titulky: 1, neslysici: 0, live: 0, premiera: 1, cb: 0, hvezdicka: 1, labeling: "1", puvodni_zneni: 1, pomer: "4:3", hd: 1)
}

//enum Zvuk: String, Codable {
//    case M = "mono"
//    case S = "stereo"
//    case D = "duální zvuk"
//
//    var description: String { rawValue }
//}

struct Dostupnost: Codable, Equatable {
    let stav: String
    let od: String
    let `do`: String
    static let example = Dostupnost(stav: "stav", od: "from", do: "do")
}

struct Obrazky: Codable, Equatable {
    let tv_program: String
    let nahled: String
    static let example = Obrazky(tv_program: "", nahled: "")
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
