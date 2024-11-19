//
//  ContentView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI

struct PokedexMainPage: View {
    @State var pokemon: Result<[Pokemon], Error>?
    @StateObject private var fetcher = PokeFetcher()
    @EnvironmentObject var favorites: PokemonFavorites
    @State private var isLoading: Bool = true
    @State private var isBouncing = false

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    Image("pokeball")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .offset(y: isBouncing ? -15 : 15)
                        .animation(
                           Animation.easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true), value: isBouncing
                            )
                            .onAppear {
                               isBouncing = true
                              }
                                Text("Loading...") 
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                } else {
                    switch fetcher.pokemonResult {
                    case nil:
                        Text("Loading...")
                            .foregroundColor(.gray)
                    case .success(let response):
                        if let results = response.results, !results.isEmpty {
                            PokemonGridView(pokemons: results.compactMap { Pokemon.map(entity: $0) })
                        } else {
                            Text("No Pokémon found.")
                                .foregroundColor(.gray)
                        }
                    case .failure(let error):
                        // Display error message and a retry button
                        VStack {
                            Text("Error: \(error.localizedDescription)")
                                .foregroundColor(.red)
                                .padding()
                            Button(action: {
                                retryFetching() // Retry the fetch operation
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
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Favourites: \(favorites.favorites.count)")
                        .font(.subheadline)
                }
            }
        }
        .task {
            await fetchPokemons()
        }
    }

    private func retryFetching() {
        isLoading = true
        Task {
            await fetchPokemons()
        }
    }

    private func fetchPokemons() async {
        do {
            try await fetcher.fetchPokemons()
            isLoading = false
        } catch {
            isLoading = false
        }
    }
}

#Preview {
    PokedexMainPage()
        .environmentObject(PokemonFavorites())
}

