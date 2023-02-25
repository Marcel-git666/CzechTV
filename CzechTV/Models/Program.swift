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
    
//    static func == (lhs: Porad, rhs: Porad) -> Bool {
//        lhs.vps == rhs.vps && lhs.datum == rhs.datum && lhs.cas == rhs.cas && lhs.dil == rhs.dil && lhs.zanr == rhs.zanr && lhs.stopaz == rhs.stopaz && lhs.noticka == rhs.noticka && lhs.regionalni == rhs.regionalni && lhs.alternativa == rhs.alternativa && lhs.linky == rhs.linky && lhs.nazvy == rhs.nazvy && lhs.ikony == rhs.ikony && lhs.obrazky == rhs.obrazky && lhs.dostupnost == rhs.dostupnost
//
//    }
    
}

struct Linky: Codable, Equatable {
    let program: String
    let ivysilani: String
}

struct Nazvy: Codable, Equatable {
    let nadtitul: String?
    let nazev: String
    let original: String?
    let nazev_casti: String?
    
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
}

struct Obrazky: Codable, Equatable {
    let tv_program: String
    let nahled: String
}

