//
//  MarsExplorerApp.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import SwiftUI

@main
struct MarsExplorerApp: App {
    @Environment(\.client) var client: MarsClient
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.client, client)
        }
    }
}
