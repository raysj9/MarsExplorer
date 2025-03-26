//
//  MarsPhoto.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import Foundation

struct MarsPhoto: Identifiable, Codable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct MarsPhotosResponse: Codable {
    let latestPhotos: [MarsPhoto]
    
    enum CodingKeys: String, CodingKey {
        case latestPhotos = "latest_photos"
    }
}
