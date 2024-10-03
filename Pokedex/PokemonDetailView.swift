//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jonah Juliao Toral on 03/10/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @EnvironmentObject var favoritePokemon: PokemonFavorites
    
    var body: some View {
            NavigationLink(destination: PokemonDetailPage(pokemon: pokemon)) {
        
                HStack{
                    Image(pokemon.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .navigationTitle(pokemon.name)
                        .padding()
                        .toolbar{
                            ToolbarItem(placement: .navigationBarTrailing){
                                Button(
                                    action:{
                                        if favoritePokemon.id.contains(pokemon.id) {
                                            favoritePokemon.id.remove(at: favoritePokemon.id.firstIndex(of: pokemon.id)!)
                                        } else {
                                            favoritePokemon.id.append(pokemon.id)
                                        }
                                    },
                                    label:{
                                        let isFavorite = favoritePokemon.id.contains(pokemon.id)
                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    }
                                )
                            }
                        }
                }
            }
    }
}

#Preview {
    PokemonDetailView(pokemon: .test)
        .environmentObject(PokemonFavorites())
}
