//
//  ImgTextCell.swift
//  testapp
//
//  Created by Naomi de Jong on 10/2/24.
//

import SwiftUI

struct PokemonCell: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                // Pokémon Image with Async Loading
                AsyncImage(url: pokemon.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(2)
                } placeholder: {
                    Image("pokeball")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(2)
                }

                // ID in the bottom-right corner of the image
                Text("#\(String(format: "%04d", pokemon.id))")
                    .font(.callout)
                    .fontWeight(.bold)
                    .padding(6)
                    .background(Color.white.opacity(0.5))
                    .foregroundColor(.black)
                    .cornerRadius(5)
                    .padding(3)
            }

            // Pokémon Name
            Text(pokemon.name.capitalized)
                .font(.system(size: 16).bold())
                .lineLimit(1) // Ensure it stays on one line
                .multilineTextAlignment(.center)
                .truncationMode(.tail) // Truncate if the name is too long
                .frame(width: 130) // Fix width to ensure consistent layout
                .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 140, height: 180) // Fixed card size
        .padding(.horizontal)
    }
}

    #Preview {
        PokemonCell(pokemon: Pokemon(id: 740, name: "crabominable")) //pkmn with the longest name
    }

