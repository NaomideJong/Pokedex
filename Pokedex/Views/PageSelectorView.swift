//
//  PageSelectorView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 20/11/2024.
//

import SwiftUI

struct PageSelectorView: View {
    @State private var selectedTab: String = "Pokedex"
    @State private var showTabs: Bool = true // Control visibility of tab buttons
    @EnvironmentObject var favorites: PokemonFavorites

    var body: some View {
        VStack {
            // Custom Tab Bar
            if showTabs {
                HStack {
                    Button(action: { selectedTab = "Pokedex" }) {
                        Text("Pokedex")
                            .padding()
                            .foregroundColor(selectedTab == "Pokedex" ? .white : .blue)
                            .background(selectedTab == "Pokedex" ? Color.blue : Color.clear)
                            .cornerRadius(8)
                    }

                    Button(action: { selectedTab = "Favorites" }) {
                        Text("Favorites")
                            .padding()
                            .foregroundColor(selectedTab == "Favorites" ? .white : .blue)
                            .background(selectedTab == "Favorites" ? Color.blue : Color.clear)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }

            // Page Content Controlled by Switch
            Spacer()
            switch selectedTab {
            case "Pokedex":
                PokedexMainPage()
            case "Favorites":
                FavoritesPage(showTabs: $showTabs)
            default:
                PokedexMainPage()
            }
            Spacer()
        }
    }
}



#Preview {
    PageSelectorView()
        .environmentObject(PokemonFavorites())
}
