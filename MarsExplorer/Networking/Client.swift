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
    let apiKey = ""
        
    @MainActor
    func fetchLatestMarsPhotos() async throws -> [MarsPhoto] {
        let path = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos"
        
        let queryItems = [URLQueryItem(name: "api_key", value: "REPLACE")]
        let response: MarsPhotosResponse = try await URLSession.shared.get(path: path, queryItems: queryItems)
        
        return response.latestPhotos
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
