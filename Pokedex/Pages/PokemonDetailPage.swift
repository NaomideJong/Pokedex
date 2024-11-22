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

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text(pokemon.name.capitalized)
                        .font(.title)
                        .bold()
                    Spacer()
                    Text("#\(String(format: "%04d", pokemon.id))") // Format ID as #0001
                        .font(.headline)
                        .bold()
                }
                .padding()

                // Display Pokémon types
                if case .success(let details) = detailFetcher.pokemonResult {
                    let types = details.types
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            ForEach(types, id: \.type.name) { typeInfo in
                                Text(typeInfo.type.name.capitalized)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(15)
                                    .background(TypeColors.color(for: typeInfo.type.name))
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }

                    }
                    .padding(.horizontal)
                }

                // Pokémon Detail View
                PokemonDetailView(pokemon: pokemon)

                // Display fetched Pokémon details or a loading/error state
                switch detailFetcher.pokemonResult {
                case .none:
                    Text("Loading Pokémon details...") // Initial state before fetch
                        .font(.headline)
                        .foregroundColor(.gray)
                case .success(let details):
                    // Pokémon details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Base Experience: \(details.baseExperience)")
                            .font(.title3)
                        Text("Height: \(details.height)")
                            .font(.title3)
                        Text("Weight: \(details.weight)")
                            .font(.title3)
                        Text("Abilities: \(details.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))")
                            .font(.title3)
                    }
                    .padding()
                case .failure(let error):
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
            .task {
                // Fetch Pokémon details
                await detailFetcher.fetchPokemonDetails(for: pokemon.id)
            }
        }
    }
}


#Preview {
    PokemonDetailPage(pokemon: Pokemon(id: 1, name: "bulbasaur"))
        .environmentObject(PokemonFavorites())
}


	
