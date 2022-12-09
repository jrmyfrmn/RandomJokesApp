//
//  WebService.swift
//  Jokerist App
//
//  Created by Created by jeremy.fermin 12/1/22.
//

import Foundation
import Combine

enum JokesError: Error {
    case invalidUrl
    case noResponse
}

enum StocksError: Error {
    case invalidServerResponse
}

protocol JokesServiceType {
    func getRandomJokes() -> AnyPublisher<[Jokes], Error>
}

class WebService: JokesServiceType {
    func getRandomJokes() -> AnyPublisher<[Jokes], Error> {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_ten") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .tryMap { data, _ in
                try JSONDecoder().decode([Jokes].self, from: data)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
