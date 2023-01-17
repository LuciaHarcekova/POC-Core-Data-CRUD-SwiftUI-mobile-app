//
//  AddNoteView.swift
//  POC-Core-Data-CRUD-SwiftUI
//
//  Created by Lucia Harceková on 14/01/2023.
//

import SwiftUI

struct AddNoteView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var text = ""
    @State private var priority = 0
    @State private var colorAsHex = ""
    @State private var color = Color.clear
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of note", text: $title)
                }

                Section {
                    TextEditor(text: $text)
                    PriorityView(priority: $priority)
                    ColorPickerView(color: $color)
                } header: {
                    Text("Write a content")
                }

                Section {
                    Button("Save") {
                        
                        let newNote = Note(context: moc)
                        newNote.id = UUID()
                        newNote.title = title
                        newNote.text = text
                        newNote.creationDate = Date()
                        newNote.priority = Int16(priority)
                        newNote.color = UIColor(color)
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Note")
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
