//
//  Created by admin on 10/2/24.
//

import Foundation

struct Pokemon : Identifiable{
    let id: UUID = UUID()
    
    let name: String
    let type: String
    
    var imageName: String{
        return name.lowercased()
    }
}

extension Pokemon{
    static let test = Pokemon(name:"Bulbasaur", type:"Grass")
}

extension Array where Element == Pokemon{
    static let test = [
        Pokemon(name: "Bulbasaur", type: "Grass"),
        Pokemon(name: "Squirtle", type: "Water"),
        Pokemon(name: "Charmander", type: "Fire"),
        Pokemon(name: "Mewtwo", type: "Psychic"),
    ]
}
