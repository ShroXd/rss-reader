//
//  rss_readerApp.swift
//  rss-reader
//
//  Created by atriiy on 2023/10/15.
//

import SwiftUI

@main
struct rss_readerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
