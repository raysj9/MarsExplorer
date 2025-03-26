//
//  URLSession+Extension.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import Foundation

extension URLSession {
    
    func get<T: Decodable>(path: String, queryItems: [URLQueryItem]? = nil) async throws -> T {
        guard var urlComponents = URLComponents(string: path) else {
            throw URLError(.badURL)
        }
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await self.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        
        return decodedData
    }
    
}
