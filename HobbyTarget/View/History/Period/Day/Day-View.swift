//
//  DayView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct DayView: View {
    
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    
    private var hobbies: FetchedResults<Hobby>
    
    // View Model
    @ObservedObject var monthVM: MonthViewModel
    @ObservedObject var periodVM = PeriodStateViewModel()
    /*
    // sheet for redacted timeForToday
    @State private var showRedactedSheet = false
    @State private var redactedTime: TimeInterval = 0
    @State private var redactedHobby: Hobby? = nil
    */
    init() {
        let context = PersistenceController.shared.container.viewContext
        _monthVM = ObservedObject(wrappedValue: MonthViewModel(context: context))
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)
            
            
            VStack {
                ForEach(hobbies, id: \.id) { hobby in
                    VStack {
                        
                        HStack {
                            Text("\(hobby.name ?? "No Name")")
                                .bold()
                            
                            Spacer()
                            
                            Text("\(periodVM.formatTime(hobby.timeForToday))")
                                .bold()
                            
                            /*
                             // Button for edit timeForToday
                             Button {
                             redactedHobby = hobby
                             redactedTime = hobby.timeForToday
                             showRedactedSheet = true
                             } label: {
                             Image(systemName: "pencil")
                             }
                             */
                        }
                        .padding()
                    }
                    
                    if hobbies.endIndex < hobbies.count - 1 || hobbies.count > 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .padding()
            /*
            .sheet(isPresented: $showRedactedSheet) {
                HStack {
                    Button {
                        showRedactedSheet = false
                        redactedTime = 0
                        redactedHobby = nil
                    } label: {
                        Text("Cancel")
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Redacted Time")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        if let hobbyUpdated = redactedHobby {
                            hobbyUpdated.timeForToday = redactedTime
                            
                            // Save in CoreData
                            do {
                                try viewContext.save()
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }
                        showRedactedSheet = false
                        redactedTime = 0
                        redactedHobby = nil
                    } label: {
                        Text("Save")
                    }
                    .padding()
                }
                
                VStack {
                    
                    HStack {
                        VStack {
                            // redacted min
                            HStack {
                                
                                Text("min")
                                
                                Button {
                                    redactedTime += 60
                                } label: {
                                    Image(systemName: "plus")
                                }
                                
                                Button {
                                    redactedTime -= 60
                                } label: {
                                    Image(systemName: "minus")
                                }
                            }
                            
                            // redacted hours
                            HStack {
                                
                                Text("hours")
                                
                                Button {
                                    redactedTime += 3600
                                } label: {
                                    Image(systemName: "plus")
                                }
                                
                                Button {
                                    redactedTime -= 3600
                                } label: {
                                    Image(systemName: "minus")
                                }
                            }
                        }
                       
                            Text("\(periodVM.formatTime(redactedTime))")
                                .bold()
                        
                    }
                    
                }
                Spacer()
            }
             */
        }
    }
}
