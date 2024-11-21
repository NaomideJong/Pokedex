//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI
import Combine

class PokemonFavorites: ObservableObject {
    @Published var favorites: [Int] = []
    
    private var cancellables: [AnyCancellable] = []
    
    init(){
        
        if let storedFavorites = UserDefaults.standard.value(forKey: "admin") as? [Int]{
            favorites = storedFavorites
        }
        
        $favorites
            .sink{ favorites in
                UserDefaults.standard.setValue(favorites, forKey: "admin")
            }
            .store(in: &cancellables)
    }
}

@main
struct PokedexApp: App {
    @StateObject var favorites = PokemonFavorites()
    
    var body: some Scene {
        WindowGroup {
            PageSelectorView()
                .environmentObject(favorites)
        }
    }
}
