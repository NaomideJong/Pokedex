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
            Image(pokemon.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
            VStack(alignment: .leading){
                Text(pokemon.name)
                    .font(.title.bold())
                Text("Type: \(pokemon.type)")
                    .font(.subheadline)
            }
        }
    }
}
    
    #Preview {
        PokemonCell(pokemon: .test)
    }

