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
    
    var elapsedTime: TimeInterval {
        get {
            return double(forKey: "elapsedTime")
        }
        set {
            set(newValue, forKey: "elapsedTime")
        }
    }
}
