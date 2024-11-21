//
//  PageSelectorView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 20/11/2024.
//

import SwiftUI

struct PageSelectorView: View {
    @State private var selectedTab: String = "Pokedex"

    var body: some View {
        ZStack {
            VStack {
                // Page Content
                if selectedTab == "Pokedex" {
                    PokedexMainPage()
                } else if selectedTab == "Favorites" {
                    FavoritesPage()
                }

                Spacer() 
            }

            VStack {
                Spacer() // Push the tab buttons to the bottom

                // Tab Buttons
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
                .background(Color.white) // Optional: Tab bar background color
                .cornerRadius(12) // Optional: Tab bar rounded corners
                .shadow(radius: 10) // Optional: Add shadow to the tab bar
            }
            .padding() // Optional: Adjust tab bar padding if needed
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure the tab bar goes below the safe area
    }
}





#Preview {
    PageSelectorView()
}
