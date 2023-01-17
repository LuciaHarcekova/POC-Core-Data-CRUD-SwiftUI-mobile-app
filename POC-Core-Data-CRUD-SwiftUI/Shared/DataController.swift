//
//  DataController.swift
//  POC-Core-Data-CRUD-SwiftUI
//
//  Created by Lucia Harceková on 14/01/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "NotesModel")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
