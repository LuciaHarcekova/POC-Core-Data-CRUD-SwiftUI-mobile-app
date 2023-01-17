//
//  ContentView.swift
//
//  Created by Lucia Harceková on 14/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.creationDate)
    ]) var notes: FetchedResults<Note>
    
    @State private var showingAddScreen = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink {
                        NoteDetailView(note: note)
                    } label: {
                        VStack(alignment: .leading) {

                            note.title.map(Text.init)
                                .font(.title)
                            
                            HStack {
                                Text("Priority: " + String(note.priority))
                                    .font(.caption)
                                
                                Spacer()

                                Text(note.creationDate ?? Date(), format: Date.FormatStyle().year().month().day().weekday().hour().minute().second().timeZone())
                                    .font(.caption)
                            }
                            
                           // Spacer()
                            Text(note.text ?? "Unknown Text")
                                .foregroundColor(.secondary)
                                .frame(height: 30)
                                .truncationMode(.tail)
                        }
                    }
                    .listRowBackground(Color(note.color ?? UIColor.clear))
                    
                    // this foes background of only small rectangle not the whole row
                    // .background(Color(note.color ?? UIColor.clear))
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddNoteView()
            }
        }
    }
    
    func deleteNotes(at offsets: IndexSet) {
        for offset in offsets {
            let book = notes[offset]
            moc.delete(book)
        }
        
        // try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
