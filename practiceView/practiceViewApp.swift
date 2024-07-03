//
//  practiceViewApp.swift
//  practiceView
//
//  Created by KKNANXX on 7/2/24.
//

import SwiftUI

@main
struct practiceViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SwiftUIView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
