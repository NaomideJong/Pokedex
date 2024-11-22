//
//  PokemonGridView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 10/9/24.
//

import SwiftUI

struct PokemonGridView: View {
    let pokemons: [Pokemon]
    @Binding var isDetailPage: Bool // Bind to track navigation

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(pokemons, id: \.id) { pokemon in
                    NavigationLink(
                        destination: PokemonDetailPage(pokemon: pokemon)
                            .onAppear { isDetailPage = true } // Set detail page to true
                            .onDisappear { isDetailPage = false } // Reset on leaving detail
                    ) {
                        PokemonCell(pokemon: pokemon)
                    }
                }
            }
            .padding()
        }
    }
}



