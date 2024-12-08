//
//  TIC_TAC_TOE_TWOApp.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 23.11.2024.
//

import SwiftUI
import SwiftData

@main
struct TIC_TAC_TOE_TWOApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            EntryView()
        }
        .modelContainer(sharedModelContainer)
    }
}
