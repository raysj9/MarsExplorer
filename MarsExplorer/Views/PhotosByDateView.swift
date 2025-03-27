//
//  PhotosByDateView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import SwiftUI

struct PhotosByDateView: View {
    @Environment(\.client) var client: MarsClient
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var state: FetchState = .preFetch
    @State private var date = Date()
    @State private var photos: [MarsPhoto] = []
    
    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }

    var body: some View {
        ScrollView {
            switch state {
            case .preFetch:
                Text("Select a date and click search")
                    .foregroundColor(.gray)
                    .padding()
            case .loading:
                ProgressView()
                    .padding()
            case .error(let error):
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            case .empty:
                Text("No photos found for this date.")
                    .foregroundColor(.gray)
                    .padding()
            case .data:
                PhotosListView(photos: photos)
                    .padding(.top, 6)
            }
        }
        .safeAreaInset(edge: isCompact ? .top : .bottom) {
            HStack {
                DatePicker(
                    "Search by Date",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                
                Spacer()
                
                Button("Search") {
                    Task { await fetchPhotos() }
                }
                .buttonStyle(.borderedProminent)
                .frame(width: 100)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.thickMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 0.75)
                    )
            }
            .padding(.horizontal, 6)
            .padding(.vertical, isCompact ? 2 : 16)
        }
        .navigationTitle("Search by Date")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    func fetchPhotos() async {
        do {
            state = .loading
            photos = try await client.fetchPhotosByDate(date: date)
            state = photos.isEmpty ? .empty : .data
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
