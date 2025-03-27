//
//  LatestPhotosView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import SwiftUI

enum FetchState: Equatable {
    case preFetch
    case loading
    case error(String)
    case empty
    case data
}

struct LatestPhotosView: View {
    
    @Environment(\.client) var client: MarsClient
    
    @State private var state: FetchState = .loading
    @State private var selectedPhoto: MarsPhoto?
    @State private var latestPhotos: [MarsPhoto] = []
    
    var body: some View {
        ScrollView {
            switch state {
            case .loading, .preFetch:
                ProgressView()
            case .error(let error):
                Text("Error: \(error)")
            case .empty:
                Text("Empty")
            case .data:
                PhotosListView(photos: latestPhotos)
            }
        }
        .navigationTitle("Latest Photos")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            Task { await fetchLatestPhotos() }
        }
        .task {
            Task { await fetchLatestPhotos() }
        }
    }
    
    func fetchLatestPhotos() async {
        do {
            state = .loading
            latestPhotos = try await client.fetchLatestMarsPhotos()
            state = latestPhotos.isEmpty ? .empty : .data
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
