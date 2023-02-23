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

struct Porad: Codable {
    
    let linky: Linky
    let vps: Int
    let datum: String
    let cas: String
    let nazvy: Nazvy
    let dil: String?
    let zanr: String
    let stopaz: String
    let noticka: String?
    let regionalni: String
    let alternativa: String
    let ikony: Ikony
    let obrazky: Obrazky
    let dostupnost: Dostupnost
    
    
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

struct Ikony: Codable, Equatable {
    let zvuk: Zvuk
    let ad: Bool
    let skryte_titulky: Bool
    let neslysici: Bool
    let live: Bool
    let premiera: Bool
    let cb: Bool
    let hvezdicka: Bool
    let labeling: String
    let puvodni_zneni: Bool
    let pomer: String
    
}

enum Zvuk: String, Codable {
    case M = "mono"
    case S = "stereo"
    case D = "duální zvuk"
    
    var description: String { rawValue }
}

struct Dostupnost: Codable, Equatable {
    let stav: String
    let od: String
    let `do`: String
}

struct Obrazky: Codable, Equatable {
    let tv_program: String
    let nahled: String
}

