//
//  LatestPhotosView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import SwiftUI

enum FetchState: Equatable {
    case loading
    case error(String)
    case empty
    case data
}

struct LatestPhotosView: View {
    
    @Environment(\.client) var client: MarsClient
    
    @State private var state: FetchState = .loading
    @State private var latestPhotos: [MarsPhoto] = []
    
    var body: some View {
        ScrollView {
            switch state {
            case .loading:
                ProgressView()
            case .error(let error):
                Text("Error: \(error)")
            case .empty:
                Text("Empty")
            case .data:
                photosView
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
       
    var photosView: some View {
        LazyVStack(spacing: 20) {
            ForEach(latestPhotos) { photo in
                PhotoRowView(photo: photo)
            }
        }
        .padding(.horizontal, 10)
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
