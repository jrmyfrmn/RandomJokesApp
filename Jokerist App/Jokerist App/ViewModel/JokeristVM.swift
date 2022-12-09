//
//  JokeristViewModel.swift
//  Jokerist App
//
//  Created by jeremy.fermin 12/1/22.
//

import Foundation
import Combine

class JokeristVM {
    
    private var cancellables = Set<AnyCancellable>()
    
    enum Input {
        case viewDidAppear
        case refreshButtonTap
    }

    enum Output {
        case fetchJokeDidFail(error: Error)
        case fetchJokeSucceed(jokes: [Jokes])
        case toggleButton(isEnabled: Bool)
        case toggleLoading(loading: Bool)
    }
    
    private let jokeServiceType: JokesServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    
    init(jokeServiceType: JokesServiceType = WebService()) {
        self.jokeServiceType = jokeServiceType
    }

    func getRandomJokes() {
        output.send(.toggleLoading(loading: true))
        output.send(.toggleButton(isEnabled: false))
        jokeServiceType.getRandomJokes().sink { [weak self] completion in
            self?.output.send(.toggleLoading(loading: false))
            self?.output.send(.toggleButton(isEnabled: true))
            switch completion {
                case .failure(let errror):
                    self?.output.send(.fetchJokeDidFail(error: errror))
                case .finished:
                    debugPrint("Random Jokes Fetch")
                }
            } receiveValue: { [weak self] joke in
                        self?.output.send(.fetchJokeSucceed(jokes: joke))
        } .store(in: &cancellables)
    }

    func getTransFormJokes(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .refreshButtonTap, .viewDidAppear:
                self?.getRandomJokes()
            }
        } .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
}
