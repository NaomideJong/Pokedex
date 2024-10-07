//
//  ImgTextCell.swift
//  testapp
//
//  Created by admin on 10/2/24.
//

import SwiftUI

struct PokemonCell: View {
    
    let pokemon: Pokemon
    var body: some View {
        HStack {
            AsyncImage(url: pokemon.icon) { image in
                            image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                        } placeholder: {
                            ProgressView() // Placeholder while loading
                        }
            VStack(alignment: .leading){
                Text(pokemon.name)
                    .font(.title.bold())
                Text("Type: \(pokemon.types)")
                    .font(.subheadline)
            }
        }
    }
}
    
    #Preview {
        PokemonCell(pokemon: .init(id:1, name:"bulbasaur", types:"grass, poison"))
    }

