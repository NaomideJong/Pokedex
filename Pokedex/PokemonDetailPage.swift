//
//  PokemonDetailPage.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI

struct PokemonDetailPage: View {
    let pokemon: Pokemon
    //let pokemonDetails: PokemonDetails
    @StateObject private var detailFetcher = PokeDetailFetcher()
    
    var body: some View {
        VStack{
            Text("pokemon detail")
        }
    }
    //.task { await detailFetcher.fetchPokemonDetails(pokemon) }
}


#Preview {
    PokemonDetailPage(pokemon: Pokemon(id: 1, name: "bulbasaur"))
}
	
