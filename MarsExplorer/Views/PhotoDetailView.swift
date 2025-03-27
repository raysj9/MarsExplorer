//
//  PhotoDetailView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: MarsPhoto
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: photo.imgSrc)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 6)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("**Rover:** \(photo.rover.name)")
                            Text("**Camera:** \(photo.camera.fullName)")
                            Text("**Earth Date:** \(photo.earthDate)")
                            Text("**Sol:** \(photo.sol)")
                        }
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.2)))
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle(photo.rover.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(item: URL(string: photo.imgSrc)!)
                }
            }
        }
    }
}
