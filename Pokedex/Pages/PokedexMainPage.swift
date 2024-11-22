//
//  ContentView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI

struct PokedexMainPage: View {
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    @EnvironmentObject var favorites: PokemonFavorites
    @State private var searchQuery: String = ""
    @Binding var isDetailPage: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // Stack without spacing to remove gaps
                // Sticky Search Bar
                TextField("Search Pokémon...", text: $searchQuery)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.vertical, 5)

                // Scrollable Content
                ScrollView {
                    if pokemonViewModel.isLoading {
                        Image("pokeball")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.top)
                        Text("Loading...")
                            .foregroundColor(.gray)
                            .padding(.top)
                    } else {
                        switch pokemonViewModel.pokemonResult {
                        case nil:
                            Text("Loading...")
                                .foregroundColor(.gray)
                                .padding(.top)
                        case .success(let pokemons):
                            if !filteredPokemons(pokemons: pokemons).isEmpty {
                                PokemonGridView(pokemons: filteredPokemons(pokemons: pokemons), isDetailPage: $isDetailPage)
                            } else {
                                Text("No Pokémon found.")
                                    .foregroundColor(.gray)
                                    .padding(.top)
                            }
                        case .failure(_):
                            VStack {
                                Text("There was an error trying to load the Pokémon. Please try again later.")
                                    .foregroundColor(.red)
                                    .padding()
                                Button(action: {
                                    // Trigger loading and fetch Pokémon
                                    pokemonViewModel.isLoading = true
                                    Task {
                                        await pokemonViewModel.fetchPokemons()
                                    }
                                }) {
                                    Text("Retry")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            if pokemonViewModel.pokemonResult == nil {
                await pokemonViewModel.fetchPokemons()
            }
        }
    }

    // Filter Pokémon Based on Search Query
    private func filteredPokemons(pokemons: [Pokemon]) -> [Pokemon] {
        if searchQuery.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
}


