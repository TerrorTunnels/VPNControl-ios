//
//  VPNControlApp.swift
//  VPNControl
//
//  Created by Robert Taylor on 2/14/25.
//

import SwiftUI

@main
struct VPNControlApp: App {
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            if settings.apiKey.isEmpty {
                NavigationStack {
                    SettingsView()
                        .environmentObject(settings)
                }
            } else {
                NavigationStack {
                    ContentView()
                        .environmentObject(settings)
                }
            }
        }
    }
}
