//
//  PokeFetcher.swift
//  Pokedex
//
//  Created by admin on 10/7/24.
//

import Foundation
import Combine

class PokeFetcher: ObservableObject {
    @Published var pokemonResult: Result<PokemonResponse, Error>?
    
    func fetchPokemon() async {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20") else { return }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let fetchedPokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonResult = .success(fetchedPokemonResponse) // Store the successful result
                }
            } catch {
                DispatchQueue.main.async {
                    self.pokemonResult = .failure(error) // Store the error
                }
                print("Error fetching Pokémon: \(error)")
            }
    }
}
