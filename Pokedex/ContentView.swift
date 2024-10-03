//
//  ContentView.swift
//  Pokedex
//
//  Created by Jonah Juliao Toral on 03/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    let pokemon: [Pokemon] = .test
    var body: some View {
        NavigationView {
            List(pokemon) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)){
                PokemonCell(pokemon: pokemon) }
        }
        
            
        }
    }
}
    
    #Preview {
        ContentView()
            .environmentObject(PokemonFavorites())
    }
    

