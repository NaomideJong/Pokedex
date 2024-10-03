//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Jonah Juliao Toral on 03/10/2024.
//

import SwiftUI

class PokemonFavorites: ObservableObject {
    @Published var id: [UUID] = []
}

@main
struct PokedexApp: App {
    @StateObject var favorites = PokemonFavorites()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites)
        }
    }
}
