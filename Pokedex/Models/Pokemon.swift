//
//  Created by admin on 10/2/24.
//

import Foundation

struct Pokemon {
    let id: Int
    private var rawName: String
    private var typesString: String // Store types as a single string

    var types: String {
        return typesString // Return the types string
    }

    var name: String {
        return rawName.capitalized
    }

    init(id: Int, name: String, types: String) {
        self.id = id
        self.rawName = name
        self.typesString = types // Store the types string directly
    }

    var image: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
    
    var icon: URL {
        let formattedId: String = String(format: "%04d", id)
        return URL(string: "https://raw.githubusercontent.com/PMDCollab/SpriteCollab/master/portrait/\(formattedId)/Normal.png")!
    }
}



struct PokemonResponse: Codable{
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonEntity]?
}

struct PokemonEntity: Codable {
    let id: Int
    let name: String?
    let url: URL?
    let types: [PokemonTypeWrapper] // Keep this for decoding

    // Custom initializer to extract the id and types
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode the name and URL
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)

        // Decode types
        self.types = try container.decode([PokemonTypeWrapper].self, forKey: .types) // Decode to an array of wrappers

        // Extract the ID from the URL if it exists
        if let urlString = try container.decodeIfPresent(String.self, forKey: .url),
           let urlComponents = URLComponents(string: urlString),
           let lastPathComponent = urlComponents.path.split(separator: "/").last,
           let id = Int(lastPathComponent) {
            self.id = id
        } else {
            throw DecodingError.dataCorruptedError(forKey: .url, in: container, debugDescription: "Invalid URL or ID not found")
        }
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case types // The key to decode types
    }
}

// Wrapper struct to decode types
struct PokemonTypeWrapper: Codable {
    let type: PokemonType // Remove optional if you're sure it will always exist

    private enum CodingKeys: String, CodingKey {
        case type
    }
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




