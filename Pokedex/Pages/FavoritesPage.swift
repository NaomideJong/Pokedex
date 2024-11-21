//
//  FavoritesPage.swift
//  Pokedex
//
//  Created by Naomi de Jong on 20/11/2024.
//

import SwiftUI

struct FavoritesPage: View {
    @EnvironmentObject var favorites: PokemonFavorites // Access shared favorite IDs
    @EnvironmentObject var pokemonViewModel: PokemonViewModel

    var body: some View {
        VStack {
            if pokemonViewModel.isLoading {
                // Show loading indicator while fetching data
                ProgressView("Loading Favorites...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                // Filter the list of pokemons to only show favorites
                let favoritePokemons = filterFavorites()

                if !favoritePokemons.isEmpty {
                    // Display the grid of favorite Pokémon
                    PokemonGridView(pokemons: favoritePokemons)
                } else {
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .onAppear {
            // Fetch Pokémon data if it's not already loaded
            if pokemonViewModel.pokemonResult == nil {
                Task {
                    await pokemonViewModel.fetchPokemons()
                }
            }
        }
        .navigationTitle("Favorites")
    }

    // Filter the list of pokemons to show only the ones marked as favorites
    private func filterFavorites() -> [Pokemon] {
        guard let pokemonResponse = pokemonViewModel.pokemonResult else {
            return []
        }

        // Ensure the result is a success and proceed to filter favorites
        if case .success(let pokemons) = pokemonResponse {
            return pokemons.filter { pokemon in
                favorites.favorites.contains(pokemon.id)
            }
        }
        return []
    }
}




