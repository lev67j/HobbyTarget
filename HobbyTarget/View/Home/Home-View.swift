//
//  ContentView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    private var hobbies: FetchedResults<Hobby>

    // View Model
    @ObservedObject var homeVM: HomeViewModel
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        _homeVM = ObservedObject(wrappedValue: HomeViewModel(context: context))
    }
    
    
  
        
    var body: some View {
        NavigationView {
            List {
                if hobbies.isEmpty {
                    EmptyHobbyView()
                } else {
                    ForEach(hobbies) { hobby in
                        NavigationLink {
                            DetailHobbyView(hobby: hobby)
                        } label: {
                            HobbyRowView(hobby: hobby)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        homeVM.showCreateHobby.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $homeVM.showCreateHobby) {
                        CreateHobbyView()
                    }
                }
            }
            Text("Select an item")
        }
    }
        
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { hobbies[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
               let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
