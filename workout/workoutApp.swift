//
//  workoutApp.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/20.
//

import SwiftUI

@main
struct workoutApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
