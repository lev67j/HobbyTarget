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
    
     // UserDefaults
     @State private var isStartTime: Bool = UserDefaults.standard.isStart
     @State private var saveTimeHobby: TimeInterval = UserDefaults.standard.saveTimeHobby
     @State private var leaveTimeUser: Date? = UserDefaults.standard.leaveTimeUser
     @State private var elapsedTime: TimeInterval = 0
     
     
     var body: some View {
         VStack(alignment: .leading) {
             
             // For test
             Text("                                                                                                                           isStartTime: \(isStartTime)                                                                                           saveTimeHobby: \(saveTimeHobby)                                                                                        elapsedTime: \(elapsedTime) ")
             
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
                 
                 if isStartTime {
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
             if isStartTime {
                 
                 saveTimeHobby += differenceTime(entryTime: Date())
                 
                 elapsedTime = saveTimeHobby
                 
                 startTimer()
             }
         }
         .onDisappear {
             if isStartTime {
                 saveTimeHobby = elapsedTime // save: hobby past time
                 UserDefaults.standard.saveTimeHobby = saveTimeHobby
                 
                 leaveTimeUser = Date()
                 UserDefaults.standard.leaveTimeUser = leaveTimeUser // save: time at which the user logged out
                 
                 elapsedTime = 0
             }
         }
     }
  
     func differenceTime(entryTime: Date) -> Double {
         guard let leaveTime = leaveTimeUser else { return 0.0 }
         
         let difference = entryTime.timeIntervalSince(leaveTime)
         
         print("\(difference) from differenceTime")
         return difference
     }

     
     func startTimer() {
         if isStartTime == false {
             isStartTime = true
             
             // save StartTime
             UserDefaults.standard.isStart = isStartTime
             
             timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                 elapsedTime += 1.0
             }
         }
     }

     private func stopTimer() {
         
         
         saveTimeHobby += elapsedTime
         hobby.timeForToday += saveTimeHobby  // test !!!!
         
         //  hobby.timeForToday += elapsedTime
         
         do {
             try viewContext.save()
         } catch {
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
         
         // stop
         elapsedTime = 0
         timer?.invalidate()
         timer = nil
         
         isStartTime = false
         saveTimeHobby = 0
         leaveTimeUser = nil
         
         // Save User Defaults
         UserDefaults.standard.isStart = isStartTime
         UserDefaults.standard.saveTimeHobby = saveTimeHobby
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
