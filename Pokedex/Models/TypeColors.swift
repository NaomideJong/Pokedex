//
//  TypeColors.swift
//  Pokedex
//
//  Created by Naomi de Jong on 22/11/2024.
//

import SwiftUI

struct TypeColors {
    static let typeColorMap: [String: Color] = [
        "Normal": .gray,
        "Fire": .red,
        "Water": .blue,
        "Grass": .green,
        "Electric": .yellow,
        "Ice": .cyan,
        "Fighting": .brown,
        "Poison": .purple,
        "Ground": .orange,
        "Flying": .teal,
        "Psychic": .pink,
        "Bug": .mint,
        "Rock": .indigo,
        "Ghost": .purple,
        "Dragon": .orange,
        "Dark": .black,
        "Steel": .gray,
        "Fairy": .pink
    ]

    static func color(for type: String) -> Color {
        return typeColorMap[type.capitalized] ?? .gray
    }
}
