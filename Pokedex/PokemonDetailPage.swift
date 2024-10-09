//
//  PokemonDetailPage.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI

struct PokemonDetailPage: View {
    //let pokemonDetails: PokemonDetails
    //@StateObject private var detailFetcher = PokeDetailFetcher()
    let pokemon: Pokemon
    @EnvironmentObject var favoritePokemon: PokemonFavorites

    @State private var scale: CGFloat = 1.0
    @State private var shake: Bool = false
    
    var body: some View {
            VStack {
                PokemonDetailView(pokemon: pokemon)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if favoritePokemon.favorites.contains(pokemon.id) {
                                favoritePokemon.favorites.remove(at: favoritePokemon.favorites.firstIndex(of: pokemon.id)!)
                            } else {
                                favoritePokemon.favorites.append(pokemon.id)
                            }
                        }, label: {
                            let isFavorite = favoritePokemon.favorites.contains(pokemon.id)
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                        })
                    }
                }
            }
        }
    
    //.task { await detailFetcher.fetchPokemonDetails(pokemon) }
}


#Preview {
    PokemonDetailPage(pokemon: Pokemon(id: 1, name: "bulbasaur"))
        .environmentObject(PokemonFavorites())
}
	
