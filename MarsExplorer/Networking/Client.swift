//
//  Client.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import Foundation
import SwiftUI

@Observable
class MarsClient {
    // https://api.nasa.gov/index.html#signUp
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String
        
    @MainActor
    func fetchLatestMarsPhotos() async throws -> [MarsPhoto] {
        let path = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos"
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        let response: MarsLatestPhotosResponse = try await URLSession.shared.get(path: path, queryItems: queryItems)
        return response.latestPhotos
    }
    
    @MainActor
    func fetchPhotosByDate(date: Date) async throws -> [MarsPhoto] {
        let path = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey), URLQueryItem(name: "earth_date", value: date.toString())]
        let response: MarsPhotosResponse = try await URLSession.shared.get(path: path, queryItems: queryItems)
        return response.photos
    }
}

struct MarsClientKey: EnvironmentKey {
    static var defaultValue: MarsClient = MarsClient()
}

extension EnvironmentValues {
    var client: MarsClient {
        get { self[MarsClientKey.self] }
        set { self[MarsClientKey.self] = newValue }
    }
}
