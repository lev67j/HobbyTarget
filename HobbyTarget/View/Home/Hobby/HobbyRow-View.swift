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
   //  @ObservedObject var appDelegate = AppDelegate()
     
     // Timer
     @State private var timer: Timer?
     @State private var isRunning: Bool = false
/*
     // UserDefaults
     @State private var isStartTime: Bool = UserDefaults.standard.isStart // for save  isStartTime.toggle() UserDefaults.standard.isStart = isStartTime
     @State private var elapsedTime: TimeInterval = UserDefaults.standard.elapsedTime
     */
     @State private var isStartTime: Bool = false
     @State private var elapsedTime: TimeInterval = 0
  
     var body: some View {
         VStack(alignment: .leading) {
             
             // For test
   //          Text("\(hobby.name ?? "Unknown")                                                                                            isStartTime: \(isStartTime)                                                                                           saveTimeHobby: \(appDelegate.saveTimeHobby)                                                                             elapsedTime: \(elapsedTime)")
             
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
         /*
         .onAppear {
             loadSavedData()
         }
         .onDisappear {
             if appDelegate.isExitApplication {
                 stopTimerForExit()
             }
         }
          */
     }
     
     func startTimer() {
         //   if isStartTime == false {
         isStartTime = true
         
         // save StartTime
 //        UserDefaults.standard.isStart = isStartTime
         
         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in      
             elapsedTime += 1.0
         }
         // }
     }

     private func stopTimer() {
         
         // save result
         hobby.timeForToday += elapsedTime
         
         do {
             try viewContext.save()
         } catch {
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
         
         // stop
         elapsedTime = 0
         isStartTime = false
         timer?.invalidate()
         timer = nil
         
         // save StartTime
       //  UserDefaults.standard.isStart = isStartTime
     }
     /*
     private func stopTimerForExit() {
         
         // save elapsedTime
         UserDefaults.standard.elapsedTime = elapsedTime
         
         timer?.invalidate()
         timer = nil
     }
         
     private func loadSavedData() {
         if let lastCloseTime = UserDefaults.standard.object(forKey: "lastCloseTime") as? Date {
             DispatchQueue.main.async {
                 appDelegate.saveTimeHobby = Date().timeIntervalSince(lastCloseTime)
             }
         }
         
         if isStartTime {
             elapsedTime += appDelegate.saveTimeHobby
             startTimer()
         }
     }
     */
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
