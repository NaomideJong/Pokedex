//
//  JokeAPI.swift
//  Pokedex
//
//  Created by admin on 10/3/24.
//

import SwiftUI

struct Joke: Codable {
    let setup: String
    let punchline: String
}

extension URLSession {
    func fetch<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await data(from: url)

        // Check for HTTP response status code
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // Decode the data into the desired type
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

import Foundation

class JokeFetcher: ObservableObject {
    @Published var jokeResult: Result<Joke, Error>? // Change to Result type
    
    func fetchJoke() async {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else { return }
        
        do {
            // Call the new fetch function
            let fetchedJoke: Joke = try await URLSession.shared.fetch(url: url)
            DispatchQueue.main.async {
                self.jokeResult = .success(fetchedJoke) // Set success result
            }
        } catch {
            DispatchQueue.main.async {
                self.jokeResult = .failure(error) // Set failure result
            }
            print("Error fetching joke: \(error)")
        }
    }
}

struct JokeAPI: View {
    @StateObject var jokeFetcher = JokeFetcher()
    
    var body: some View {
        VStack {
            if let result = jokeFetcher.jokeResult {
                switch result {
                case .success(let joke):
                    Text(joke.setup)
                        .font(.headline)
                        .padding()
                    Text(joke.punchline)
                        .font(.subheadline)
                        .padding()
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                        .font(.subheadline)
                        .padding()
                }
            } else {
                Text("Loading joke...")
                    .font(.subheadline)
                    .padding()
            }
            
            // New Joke Button
            Button(action: {
                Task {
                    await jokeFetcher.fetchJoke() // Fetch a new joke
                }
            }) {
                Text("New Joke")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20) // Add some spacing above the button
        }
        .onAppear {
            Task {
                await jokeFetcher.fetchJoke() // Fetch the initial joke
            }
        }
    }
}



#Preview {
    JokeAPI()
}
