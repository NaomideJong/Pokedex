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
                        withAnimation(Animation.easeInOut(duration: 0.3).repeatCount(1, autoreverses: true)) {
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
   
            }
        }
    }
    

#Preview {
    PokemonDetailView(pokemon: Pokemon(id: 1, name: "bulbasaur"))
}


