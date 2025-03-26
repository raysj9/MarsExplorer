//
//  Rover.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import Foundation

struct Rover: Identifiable, Codable {
    let id: Int
    let name: String
    let launchDate: String
    let landingDate: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case launchDate = "launch_date"
        case landingDate = "landing_date"
        case status
    }
}
