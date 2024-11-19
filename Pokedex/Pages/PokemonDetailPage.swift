//
//  PokemonDetailPage.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI

struct PokemonDetailPage: View {
    let pokemon: Pokemon
    @EnvironmentObject var favoritePokemon: PokemonFavorites
    @StateObject private var detailFetcher = PokeDetailFetcher() 

    @State private var scale: CGFloat = 1.0
    @State private var shake: Bool = false
    
    var body: some View {
        VStack {
            
            Text(pokemon.name.capitalized)
                .font(.title)
                .bold()
                .padding()
                
            
            // Pokémon Detail View
            PokemonDetailView(pokemon: pokemon)
                       
            // Display the fetched Pokémon details or a loading/error state
            switch detailFetcher.pokemonResult {
            case .none:
                Text("Loading Pokémon details...") // Initial state before fetch
                    .font(.headline)
                    .foregroundColor(.gray)
            case .success(let details):
                
                // Display Pokémon details if fetch is successful
                VStack(alignment: .leading, spacing: 15) {
                    Text("Name: \(pokemon.name)")
                        .font(.title3)
                    Text("ID: \(pokemon.id)")
                        .font(.title3)
                    Text("Base Experience: \(details.baseExperience)")
                        .font(.title3)
                    Text("Height: \(details.height)")
                        .font(.title3)
                    Text("Weight: \(details.weight)")
                        .font(.title3)

                    Text("Type: \(details.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                        .font(.title3)
                    
                    Text("Abilities: \(details.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))")
                        .font(.title3)
                    
                }
                .padding()
            case .failure(let error):
                // Display an error message if the fetch fails
                Text("Failed to load Pokémon details: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if favoritePokemon.favorites.contains(pokemon.id) {
                        favoritePokemon.favorites.remove(at: favoritePokemon.favorites.firstIndex(of: pokemon.id)!)
                    } else {
                        favoritePokemon.favorites.append(pokemon.id)
                    }
                }) {
                    let isFavorite = favoritePokemon.favorites.contains(pokemon.id)
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                }
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .task {
            // Ensure the ID matches the expected type in fetchPokemonDetails
            await detailFetcher.fetchPokemonDetails(for: pokemon.id)
        }
    }
}

#Preview {
    PokemonDetailPage(pokemon: Pokemon(id: 1, name: "bulbasaur"))
        .environmentObject(PokemonFavorites())
}


	
