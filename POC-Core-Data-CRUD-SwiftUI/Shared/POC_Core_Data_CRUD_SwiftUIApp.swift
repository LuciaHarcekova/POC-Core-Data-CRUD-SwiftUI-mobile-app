//
//  POC_Core_Data_CRUD_SwiftUIApp.swift
//
//  Created by Lucia Harceková on 14/01/2023.
//

import SwiftUI

@main
struct POC_Core_Data_CRUD_SwiftUIApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
