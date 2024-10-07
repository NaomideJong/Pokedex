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
    
    var body: some View {
        NavigationView {
            VStack {
                switch fetcher.pokemonResult {
                case nil:
                    Text("Loading...") // Placeholder while loading
                        .foregroundColor(.gray)
                case .success(let response):
                    List(response.results ?? [], id: \.id) { entity in
                        if let name = entity.name {
                            let typesString = entity.types.map { $0.type.rawValue }.joined(separator: ", ")
                            let pokemon = Pokemon(id: entity.id, name: name, types: typesString)
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCell(pokemon: pokemon)
                            }
                        }
                    }
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Pokédex")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Favourites: \(favorites.favorites.count)")
                        .font(.subheadline)
                }
            }
        }
        .task { await fetcher.fetchPokemon() }
    }
}


    #Preview {
        PokedexMainPage()
            .environmentObject(PokemonFavorites())
    }
    

