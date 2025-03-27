//
//  MarsTabView.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import SwiftUI

enum MarsTab: CaseIterable {
    case latest
    case searchByDate
    
    var title: String {
        switch self {
        case .latest: "Latest Photos"
        case .searchByDate: "Search by Date"
        }
    }
    
    @ViewBuilder
    var tabView: some View {
        switch self {
        case .latest:
            LatestPhotosView()
        case .searchByDate:
            PhotosByDateView()
        }
    }
    
    var icon: String {
        switch self {
        case .latest: "flame"
        case .searchByDate: "calendar"
        }
    }
}

struct MarsTabView: View {
    @State private var selectedTab: MarsTab = .latest
        
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MarsTab.allCases, id: \.self) { tab in
                Tab(tab.title, systemImage: tab.icon, value: tab) {
                    NavigationStack {
                        tab.tabView
                    }
                }
            }
        }
    }
}
