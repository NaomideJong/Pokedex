//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by admin on 10/9/24.
//

import Foundation

struct PokemonDetails: Codable{
    let id: Int
    let abilities: [AbilitiesEntity]?
    let cries: URL?
    let height: Int?
    let weight: Int?
    let types: [String]?
}

//extension PokemonDetails {
//    static func map(entity: PokemonEntity) -> Self? {
//        // If the name is nil, return a MissingNo instance
//        guard let name = entity.name else {
//            return Pokemon(id: 0, name: "MissingNo.")
//        }
//        return Pokemon(id: entity.id, name: name)
//    }
//}

struct PokemonDetailResponse: Codable{
    let id: Int
    let abilities: [AbilitiesEntity]?
    let cries: URL?
    let height: Int?
    let types: [String]?
}


struct AbilitiesEntity: Codable{
    let name: String?
    let URL: URL?
    let isHidden: Bool?
}

enum PokemonType: String, Codable {
    case normal = "normal"
    case fighting = "fighting"
    case flying = "flying"
    case poison = "poison"
    case ground = "ground"
    case rock = "rock"
    case bug = "bug"
    case ghost = "ghost"
    case steel = "steel"
    case fire = "fire"
    case water = "water"
    case grass = "grass"
    case electric = "electric"
    case psychic = "psychic"
    case ice = "ice"
    case dragon = "dragon"
    case dark = "dark"
    case fairy = "fairy"
}
