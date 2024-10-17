//
//  UserDefaults.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 25.09.2024.
//

import Foundation

extension UserDefaults {
    
    var isStart: Bool {
        get {
            return bool(forKey: "isStart")
        }
        set {
            set(newValue, forKey: "isStart")
        }
    }
    
    var saveTimeHobby: TimeInterval {
        get {
            return double(forKey: "elapsedTime")
        }
        set {
            set(max(newValue, 0), forKey: "elapsedTime")
        }
    }
    
    var leaveTimeUser: Date? {
        get {
            return object(forKey: "leaveTimeUser") as? Date
        }
        set {
            set(newValue, forKey: "leaveTimeUser")
        }
    }
}
