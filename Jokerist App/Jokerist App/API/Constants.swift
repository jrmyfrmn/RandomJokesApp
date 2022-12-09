//
//  Constants.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 12/1/22.
//

import Foundation

struct Constants {
    struct Urls {
        static let randomJokes = URL(string: "https://official-joke-api.appspot.com/random_ten")!
    }
}

//enum Constants: String {
//
//    private var baseURL: String { return "https://official-joke-api.appspot.com/random_ten" }
//    case randomJokes = "/jokes"
//
//    var url: URL {
//        guard let url = URL(string: baseURL) else {
//            preconditionFailure("The url used in \(Constants.self) is not valid")
//        }
//        return url.appendingPathComponent(self.rawValue)
//    }
//}
