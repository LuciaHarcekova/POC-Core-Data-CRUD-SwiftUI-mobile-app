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
            Text("Priority: " + String(note.priority))
            Text("Color as HEX: " + (note.colorAsHex ?? "No color as HEX"))
            Text(note.text ?? "No text")
                .background(Rectangle().fill(Color(note.color ?? UIColor.clear)))
        }
        .navigationTitle(note.title ?? "Unknown Note")
        .navigationBarTitleDisplayMode(.inline)
        
        // Delete functionality
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this note", systemImage: "trash")
            }
        }
        .alert("Delete note?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteNote)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        
    }
    
    func deleteNote() {
        moc.delete(note)
        
        // try? moc.save()
        dismiss()
    }
}
