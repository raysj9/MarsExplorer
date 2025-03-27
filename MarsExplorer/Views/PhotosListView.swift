//
//  PhotosListView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import SwiftUI

struct PhotosListView: View {
    let photos: [MarsPhoto]
    
    @State private var selectedPhoto: MarsPhoto?
    
    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 300), spacing: 20)
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(photos) { photo in
                    PhotoRowView(photo: photo)
                        .onTapGesture {
                            selectedPhoto = photo
                        }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical)
        }
        .sheet(item: $selectedPhoto, content: { photo in
            PhotoDetailView(photo: photo)
                .presentationBackground(.thinMaterial)
        })
    }
}
