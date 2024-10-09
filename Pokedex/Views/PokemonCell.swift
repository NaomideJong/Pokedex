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
            AsyncImage(url: pokemon.icon) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(2)
            } placeholder: {
                ProgressView() // Placeholder while loading
            }
            
            Text(pokemon.name.capitalized)
                .font(.system(size: 16).bold())
                .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 200, height: 200)
        .padding(.horizontal)
    }
}

    #Preview {
        PokemonCell(pokemon: Pokemon(id: 740, name: "crabominable")) //pkmn with the longest name
    }

