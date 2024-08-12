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
    
     @State private var timer: Timer?
     @State private var elapsedTime: TimeInterval = 0.0
     @State private var isRunning: Bool = false

     var body: some View {
         VStack(alignment: .leading) {
             Text(hobby.name ?? "Unknown")
                 .font(.headline)
             Text("today \(formatTime(hobby.timeForToday))")
                   .font(.subheadline)
                 .foregroundColor(.gray)
             
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
                 
                 Text(formatTime(elapsedTime))
                    
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
     }
     
     private func startTimer() {
         if !isRunning {
             isRunning = true
             timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: true) { _ in
                 elapsedTime += 1.0
             }
         }
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
         isRunning = false
         timer?.invalidate()
         timer = nil
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

 
 
