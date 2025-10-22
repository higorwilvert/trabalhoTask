//
//  TaskManagerV02App.swift
//  TaskManagerV02
//
//  Created by Guest User on 22/10/25.
//

import SwiftUI
import CoreData

@main
struct GerenciadorTarefasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListaTarefasView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
