//
//  PokemonGridView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 10/9/24.
//

import SwiftUI

struct PokemonGridView: View {
    let pokemons: [Pokemon]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
                   LazyVGrid(columns: columns, spacing: 20) {
                       ForEach(pokemons, id: \.id) { pokemon in
                           NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                               PokemonCell(pokemon: pokemon)
                           }
                       }
            }
            .padding()
        }
        .navigationTitle("Pokédex")
    }
}



struct PokemonGridView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPokemons = [
            Pokemon(id: 92, name: "Gastly"),
            Pokemon(id: 93, name: "Haunter"),
            Pokemon(id: 94, name: "Gengar"),
            Pokemon(id: 0, name: "MissingNo.")
        ]

        NavigationView {
            PokemonGridView(pokemons: mockPokemons)
        }
    }
}
