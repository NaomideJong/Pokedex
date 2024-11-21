//
//  FavoritesPage.swift
//  Pokedex
//
//  Created by Naomi de Jong on 20/11/2024.
//

import SwiftUI

struct FavoritesPage: View {
    @Binding var showTabs: Bool
    @EnvironmentObject var favorites: PokemonFavorites
    @StateObject private var fetcher = PokeFetcher()

    var body: some View {
        NavigationView {
            VStack {
                Text("Favorites")
                    .font(.title)
                    .padding()
                
            }
        }
        
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            }
        }
    }
}

#Preview {
    FavoritesPage(showTabs: .constant(false))
}
