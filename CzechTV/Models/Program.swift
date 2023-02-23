//
//  Program.swift
//  CzechTV
//
//  Created by Marcel Mravec on 23.02.2023.
//

import Foundation

struct Program {
    let porad: [Porad]
}

struct Porad {
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
    
}

struct Linky {
    let program: String
    let ivysilani: String
}

struct Nazvy {
    let nadtitul: String?
    let nazev: String
    let original: String?
    let nazev_casti: String?
    
}

struct Ikony {
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

enum Zvuk: String {
    case M = "mono"
    case S = "stereo"
    case D = "duální zvuk"
    
    var description: String { rawValue }
}

struct Dostupnost {
    let stav: String
    let od: String
    let `do`: String
}

struct Obrazky {
    let tv_program: String
    let nahled: String
}

