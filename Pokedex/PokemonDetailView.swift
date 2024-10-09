//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Naomi de Jong on 03/10/2024.
//

import SwiftUI
import UIKit



struct PokemonDetailView: View {
    let pokemon: Pokemon
    @EnvironmentObject var favoritePokemon: PokemonFavorites

    @State private var scale: CGFloat = 1.0
    @State private var shake: Bool = false
    
    var body: some View {
            VStack {
                AsyncImage(url: pokemon.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(scale) // Apply scaling
                        .rotationEffect(.degrees(shake ? 10 : 0)) // Apply shake rotation
                        .padding()
                } placeholder: {
                    ProgressView() // Placeholder while loading
                }
                .navigationTitle(pokemon.name.capitalized)
                .onAppear {
                    // Introduce a small delay before starting the animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        // Scale the image up initially
                        scale = 1.2
                        
                        // Start the shake animation once
                        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(1, autoreverses: true)) {
                            shake.toggle() // Start shaking
                        }
                        
                        // Reset scale back to original after shaking
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                scale = 1.0 // Reset scale back to original
                                shake = false // Ensure shake is reset
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if favoritePokemon.favorites.contains(pokemon.id) {
                                favoritePokemon.favorites.remove(at: favoritePokemon.favorites.firstIndex(of: pokemon.id)!)
                            } else {
                                favoritePokemon.favorites.append(pokemon.id)
                            }
                        }, label: {
                            let isFavorite = favoritePokemon.favorites.contains(pokemon.id)
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                        })
                    }
                }
            }
        }
    }
    

#Preview {
    PokemonDetailView(pokemon: Pokemon(id: 1, name: "bulbasaur"))
        .environmentObject(PokemonFavorites())
   
}


