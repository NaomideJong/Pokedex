//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by admin on 10/9/24.
//

import Foundation

struct PokemonDetails: Codable{
    let id: Int
    let abilities: [String]?
    let height: Int?
    let weight: Int?
    let types: [String]?
    let baseExperience: Int?
}

//extension PokemonDetails{
//    static func map(entity: PokemonDetailEntity) -> Self?{
//        return PokemonDetails(id: entity.id, abilities: entity.abilities, height: entity.height, weight: entity.weight, types: entity.types, baseExperience: entity.baseExperience)
//    }
//}

struct PokemonDetailEntity: Codable{

    let height: Int?
    let weight: Int?
    let types: [TypeEntity]?
    let abilities: [AbilitiesEntity]?
    let baseExperience: Int?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        self.types = try container.decodeIfPresent([TypeEntity].self, forKey: .types)
        self.abilities = try container.decodeIfPresent([AbilitiesEntity].self, forKey: .abilities)
        self.baseExperience = try container.decodeIfPresent(Int.self, forKey: .baseExperience)
    }
}

struct PokemonDetailResponse: Codable {
    let name: String
    let abilities: [AbilitiesEntity]
    let types: [TypeEntity]
    let height: Int
    let weight: Int
    let baseExperience: Int

    enum CodingKeys: String, CodingKey {
        case name, abilities, types, height, weight
        case baseExperience = "base_experience"
    }
}

struct AbilitiesEntity: Codable {
    let ability: NamedAPIResource
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct TypeEntity: Codable {
    let slot: Int
    let type: NamedAPIResource
}

struct NamedAPIResource: Codable {
    let name: String
    let url: URL
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
