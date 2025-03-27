//
//  PhotoRowView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import SwiftUI

struct PhotoRowView: View {
    let photo: MarsPhoto
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("**Rover:** \(photo.rover.name)")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("**Camera:** \(photo.camera.name)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("**Earth Date:** \(photo.earthDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("**Sol:** \(photo.sol)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing, 16)
            
            Spacer()
            
            AsyncImage(url: URL(string: photo.imgSrc)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 6)
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .overlay(ProgressView())
            }
            .frame(width: 150, height: 150)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .shadow(radius: 2)
        )
    }
}

