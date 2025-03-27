//
//  PhotosByDateView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import SwiftUI

struct PhotosByDateView: View {
    @Environment(\.client) var client: MarsClient
    
    @State private var state: FetchState = .preFetch
    @State private var date = Date()
    @State private var photos: [MarsPhoto] = []

    var body: some View {
        VStack(spacing: 20) {
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
            .padding([.leading, .trailing])
            
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
                        .padding(.top, 10)
                }
            }
        }
        .padding(.top, 8)
        .navigationTitle("Search by Date")
        .navigationBarTitleDisplayMode(.inline)
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
