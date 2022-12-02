//
//  WebService.swift
//  Jokerist App
//
//  Created by Created by jeremy.fermin 12/1/22.
//

import Foundation
import Combine

enum StocksError: Error {
    case invalidServerReponse
}

class WebService:  NSObject {
    
    func getJokes(url: URL) async throws -> [Jokes] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw StocksError.invalidServerReponse
        }
        
        return try JSONDecoder().decode([Jokes].self, from: data)
    }
}
    

