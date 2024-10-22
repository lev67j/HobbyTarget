//
//  HobbyRowViewModel.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 21.10.2024.
//

import Foundation
import CoreData

final class HobbyRowViewModel: ObservableObject {
    
   
    //MARK: - Init
    private var context: NSManagedObjectContext
    init(context: NSManagedObjectContext, hobby: Hobby) {
        self.context = context
        self.hobby = hobby
    }
    
    
    
    //MARK: - Properties
    
    // Hobby
    var hobby: Hobby
    
    // Timer
    @Published var timer: Timer?
    
    // UserDefaults
    @Published var isStartTime: Bool = UserDefaults.standard.isStart
    @Published var isExitStart: Bool = UserDefaults.standard.isExitStart
    @Published var saveTimeHobby: TimeInterval = UserDefaults.standard.saveTimeHobby
    @Published var leaveTimeUser: Date? = UserDefaults.standard.leaveTimeUser
    @Published var elapsedTime: TimeInterval = 0
    
    
    
    
    //MARK: - Methods
    
    func differenceTime(entryTime: Date) -> Double {
        guard let leaveTime = leaveTimeUser else { return 0.0 }
        
        let difference = entryTime.timeIntervalSince(leaveTime)
        
        print("\(difference) from differenceTime")
        return difference
    }

    
    func startTimer() {
        if  isStartTime == false {
             isStartTime = true
            
            // save StartTime
            UserDefaults.standard.isStart = isStartTime
            
             timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                 self.elapsedTime += 1.0
            }
        }
    }

    func stopTimer() {
       
       
       saveTimeHobby += elapsedTime
       hobby.timeForToday += saveTimeHobby  // test !!!!
       
       //  hobby.timeForToday += elapsedTime
       
       do {
           try context.save()
       } catch {
           let nsError = error as NSError
           fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
       }
       
       // stop
       elapsedTime = 0
       timer?.invalidate()
       timer = nil
       
       isStartTime = false
      // isExitStart = false            // test
       saveTimeHobby = 0
       leaveTimeUser = nil
       
       // Save User Defaults
       UserDefaults.standard.isStart = isStartTime
       UserDefaults.standard.saveTimeHobby = saveTimeHobby
       // UserDefaults.standard.isExitStart = isExitStart   // test
   }
    
   
   
     func formatTime(_ time: TimeInterval) -> String {
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
    
    
    
    // TEST!
    func exitStartTimer() {
           
           timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
               self.elapsedTime += 1.0
            }
            
            // save
           UserDefaults.standard.isExitStart = isExitStart
        
    }
}
