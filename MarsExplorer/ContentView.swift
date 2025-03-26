//
//  ContentView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/25/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.client) var client: MarsClient
    
    var body: some View {
        NavigationStack {
            LatestPhotosView()
        }
    }
}
