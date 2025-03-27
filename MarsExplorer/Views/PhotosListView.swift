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
        LazyVStack(spacing: 20) {
            ForEach(photos) { photo in
                PhotoRowView(photo: photo)
                    .onTapGesture {
                        selectedPhoto = photo
                    }
            }
        }
        .padding(.horizontal, 10)
        .sheet(item: $selectedPhoto, content: { photo in
            PhotoDetailView(photo: photo)
                .presentationBackground(.thinMaterial)
        })
    }
}
