//
//  Created by Naomi de Jong on 10/2/24.
//

import Foundation

struct Pokemon {
    let id: Int
    let name: String

    var image: URL {
        if id == 0 {
            return URL(string: "https://archives.bulbagarden.net/media/upload/9/98/Missingno_RB.png")!
        }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}

extension Pokemon {
    static func map(entity: PokemonEntity) -> Self? {
        // If the name is nil, return a MissingNo instance
        guard let name = entity.name else {
            return Pokemon(id: 0, name: "MissingNo.")
        }
        return Pokemon(id: entity.id, name: name)
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

    // Custom initializer to extract the id
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode the name and URL
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)

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
    }
}







