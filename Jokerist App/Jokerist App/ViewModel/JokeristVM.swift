//
//  JokeristViewModel.swift
//  Jokerist App
//
//  Created by jeremy.fermin 12/1/22.
//

import Foundation
import Combine

class JokeristVM: NSObject {
    
    private(set) var joke: [Jokes] = []
    
    func getAJoke(url: URL) async {
        do {
            let jokes = try await WebService().getJokes(url: url)
            self.joke = jokes
        } catch {
            print(error)
        }
    }    
}
