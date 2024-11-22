//
//  PageSelectorView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 20/11/2024.
//

import SwiftUI

struct PageSelectorView: View {
    @State private var selectedTab: String = "Pokedex"
    @State private var isDetailPage: Bool = false // Tracks if we are on a detail page

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if selectedTab == "Pokedex" {
                        PokedexMainPage(isDetailPage: $isDetailPage)
                    } else if selectedTab == "Favorites" {
                        FavoritesPage(isDetailPage: $isDetailPage)
                    }
                }

                if !isDetailPage {
                    VStack {
                        Spacer()
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
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Reset `isDetailPage` on view load
            isDetailPage = false
        }
    }
}


#Preview {
    PageSelectorView()
}
