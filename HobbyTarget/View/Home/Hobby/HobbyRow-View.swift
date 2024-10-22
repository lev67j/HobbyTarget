//
//  HobbyRowView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

 import SwiftUI

 struct HobbyRowView: View {
     
     // Core Data
     @Environment(\.managedObjectContext) private var viewContext
     var hobby: Hobby
    
     // AppDelegate
     @ObservedObject var appDelegate = AppDelegate()
     
     // Timer
     @State private var timer: Timer?
     @State private var elapsedTime: TimeInterval = 0
    
     // UserDefaults
    // @State private var isStartTime: Bool = UserDefaults.standard.isStart
    // @State private var saveTimeHobby: TimeInterval = UserDefaults.standard.saveTimeHobby
    // @State private var leaveTimeUser: Date? = UserDefaults.standard.leaveTimeUser
    
     
     var body: some View {
         VStack(alignment: .leading) {
             
             // For test
             Text("                                                                                                                           isStartTime: \(hobby.isStartTime)                                                                                           saveTimeHobby: \(String(format: "%.1f", hobby.saveTimeHobby))                                                                            elapsedTime: \(String(format: "%.1f", elapsedTime)) ")
             
             HStack {
                 Text("\(hobby.name ?? "Unknown")")
                     .font(.headline)
                     .foregroundStyle(.black)
                 
                 Spacer()
                 
                 Text("\(hobby.isFavourite ? "⭐️" : "")")
                     .font(.headline)
                     .foregroundStyle(.black)
             }
             
             Divider()
             
             HStack {
                 Button {
                     startTimer()
                 } label: {
                     Text("Start")
                         .frame(maxWidth: .infinity)
                         .padding()
                         .background(Color.green)
                         .foregroundColor(.white)
                         .cornerRadius(10)
                 }
                 .buttonStyle(PlainButtonStyle())
                 
                 if hobby.isStartTime {
                     Text(formatTime(elapsedTime))
                         .foregroundStyle(.black)
                 }
                 
                 Button {
                     stopTimer()
                 } label: {
                     Text("Stop")
                         .frame(maxWidth: .infinity)
                         .padding()
                         .background(Color.red)
                         .foregroundColor(.white)
                         .cornerRadius(10)
                 }
                 .buttonStyle(PlainButtonStyle())
             }
             .padding(.top, 8)
         }
         .padding()
         .background(Color.white)
         .cornerRadius(15)
         .shadow(radius: 5)
         .padding(.horizontal)
         .onAppear {
             if hobby.isStartTime {
                 
                 hobby.saveTimeHobby += differenceTime(entryTime: Date())
                 
                 elapsedTime = hobby.saveTimeHobby
                 
                 exitStartTimer()
                 
                 hobby.leaveTimeUser = nil
               
                 do {
                     try viewContext.save()
                 } catch {
                     let nsError = error as NSError
                     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                 }
             }
         }
         .onDisappear {
             if hobby.isStartTime {
                 hobby.saveTimeHobby = elapsedTime // save: hobby past time
                 
                 hobby.leaveTimeUser = Date()
                 
                 elapsedTime = 0
                 
                 do {
                     try viewContext.save()
                 } catch {
                     let nsError = error as NSError
                     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                 }
             } else {
                 hobby.saveTimeHobby = 0
                 
                 do {
                     try viewContext.save()
                 } catch {
                     let nsError = error as NSError
                     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                 }
             }
         }
     }
  
     func differenceTime(entryTime: Date) -> Double {
         guard let leaveTime = hobby.leaveTimeUser else { return 0.0 }
         
         let difference = entryTime.timeIntervalSince(leaveTime)
         
         print("\(difference) from differenceTime")
         return difference
     }

     
      func exitStartTimer() {
          if timer == nil {
              timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                  elapsedTime += 1.0
              }
          }
      }
     
     func startTimer() {
         if hobby.isStartTime == false {
             hobby.isStartTime = true
           
             timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                 elapsedTime += 1.0
             }
             
             do {
                 try viewContext.save()
             } catch {
                 let nsError = error as NSError
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
         }
     }

     private func stopTimer() {
         
         
         hobby.saveTimeHobby += elapsedTime
         hobby.timeForToday += hobby.saveTimeHobby  // test !!!!
         
         //  hobby.timeForToday += elapsedTime
         
    
         // stop
         elapsedTime = 0
         timer?.invalidate()
         timer = nil
         
         hobby.isStartTime = false
         hobby.saveTimeHobby = 0
         hobby.leaveTimeUser = nil
         
         do {
             try viewContext.save()
         } catch {
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
     }
     
    
    
     private func formatTime(_ time: TimeInterval) -> String {
         let hours = Int(time) / 3600
         let minutes = (Int(time) % 3600) / 60
      
         if hours > 0 {
             return "\(hours)h \(minutes)min"
         } else if minutes > 0 {
             return "\(minutes)min"
         } else {
             return "0min"
         }
     }
 }
