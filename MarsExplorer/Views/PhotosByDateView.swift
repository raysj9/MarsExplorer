//
//  PhotosByDateView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import SwiftUI

struct PhotosByDateView: View {
    @State private var state: FetchState = .loading
    @State private var date = Date()
    @State private var photos: [MarsPhoto] = []

    var body: some View {
        VStack {
            HStack {
                DatePicker(
                    "Search by Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                
                Spacer()
                
                Button("Search") {
                    fetchPhotos()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            ScrollView {
                switch state {
                case .loading:
                    ProgressView()
                case .error(let error):
                    Text("Error \(error)")
                case .empty:
                    Text("Empty")
                case .data:
                    PhotosListView(photos: photos)
                }
            }
        }
    }
    
    func fetchPhotos() {
        
    }
}

