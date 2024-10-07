//
//  PokemonDetailPage.swift
//  Pokedex
//
//  Created by Jonah Juliao Toral on 03/10/2024.
//

import SwiftUI

struct PokemonDetailPage: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack{
            Text("pokemon detail")
        }
    }
}
#Preview {
    PokemonCell(pokemon: .init(id:1, name:"bulbasaur", types:"grass, poison"))
}
	
