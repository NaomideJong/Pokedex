//
//  PokemonDetailFetcher.swift
//  Pokedex
//
//  Created by admin on 10/9/24.
//

import Foundation
import Combine

class PokeDetailFetcher: ObservableObject {
    @Published var pokemonResult: Result<PokemonDetailResponse, Error>?
        
    func fetchPokemonDetails(for id: Int) async{
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedPokemonDetailResponse = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
            DispatchQueue.main.async {
                self.pokemonResult = .success(fetchedPokemonDetailResponse) // Store the successful result
            }
        } catch {
            DispatchQueue.main.async {
                self.pokemonResult = .failure(error) // Store the error
            }
            print("Error fetching Pokémon: \(error)")
        }
    }
}
