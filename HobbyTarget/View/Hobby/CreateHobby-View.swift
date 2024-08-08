//
//  CreateHobby-View.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

import SwiftUI

struct CreateHobbyView: View {
    
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    private var hobbies: FetchedResults<Hobby>
    
    
    // Dismiss
    @Environment(\.dismiss) var dismiss
    
    // View Model
    @ObservedObject var createVM = CreateHobbyViewModel()
  
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $createVM.name)
                        
                        TextField("Time target", text: $createVM.timeTarget)
                        
                        Toggle("Favourite", isOn: $createVM.isFavourite)
                        
                        DatePicker("Date start", selection: $createVM.dateStart)
                        
                    }
                    
                    Section("Notes") {
                        TextEditor(text: $createVM.notes)
                    }
                }
                .navigationTitle("Add Hobby")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                  
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // save context
                            let newHobby = Hobby(context: viewContext)
                            newHobby.name = createVM.name
                            newHobby.isFavourite = createVM.isFavourite
                            newHobby.notes = createVM.notes
                            newHobby.timeTarget =  createVM.timeTarget
                            newHobby.dateStart = createVM.dateStart
                            
                            do {
                                try viewContext.save()
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            
                            print(newHobby.name!)
                            
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CreateHobbyView()
}
