//
//  NoteDetailView.swift
//  POC-Core-Data-CRUD-SwiftUI
//
//  Created by Lucia Harceková on 14/01/2023.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            Text(note.text ?? "No text")
                .background(Rectangle().fill(Color(note.color ?? UIColor.blue)))
            Text(note.colorAsHex ?? "No colorAsHex")
        }
        .navigationTitle(note.title ?? "Unknown Note")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete note?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteNote)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this note", systemImage: "trash")
            }
        }
    }
    
    func deleteNote() {
        moc.delete(note)
        
        // try? moc.save()
        dismiss()
    }
}
