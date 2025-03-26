//
//  Camera.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import Foundation

struct Camera: Identifiable, Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}
