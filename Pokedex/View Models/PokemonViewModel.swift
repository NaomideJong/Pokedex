//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Naomi de Jong on 21/11/2024.
//

import Combine
import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemonResult: Result<[Pokemon], Error>?
    @Published var isLoading: Bool = true

    private let fetcher = PokeFetcher()

    func fetchPokemons() async {
        self.isLoading = true

        await fetcher.fetchPokemons()

        switch self.fetcher.pokemonResult {
        case .success(let response):
            let pokemons = response.results?.compactMap { Pokemon.map(entity: $0) } ?? []
            self.pokemonResult = .success(pokemons)
        case .failure(let error):
            self.pokemonResult = .failure(error)
        case nil:
            break
        }
        self.isLoading = false
    }
}

