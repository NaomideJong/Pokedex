//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jonah Juliao Toral on 03/10/2024.
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
                        Image(pokemon.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(scale) // Apply scaling
                            .rotationEffect(.degrees(shake ? 10 : 0)) // Apply shake rotation
                            .padding()
                            .navigationTitle(pokemon.name)
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
                                        if favoritePokemon.id.contains(pokemon.id) {
                                            favoritePokemon.id.remove(at: favoritePokemon.id.firstIndex(of: pokemon.id)!)
                                        } else {
                                            favoritePokemon.id.append(pokemon.id)
                                        }
                                    }, label: {
                                        let isFavorite = favoritePokemon.id.contains(pokemon.id)
                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    })
                                }
                            }
                    }
                }
            }

#Preview {
    PokemonDetailView(pokemon: .test)
        .environmentObject(PokemonFavorites())
   
}
