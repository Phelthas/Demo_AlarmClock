//
//  DCAlarmManager.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

class DCAlarmManager {
    var alarmArray: NSMutableArray
    
    static let sharedInstance = DCAlarmManager()
    
    
    fileprivate init() {
        if let alarmArrayData = kLXMUserDefaults.object(forKey: "alarmArray") as? Data {
            let tempArray = NSKeyedUnarchiver.unarchiveObject(with: alarmArrayData) as! NSArray
            self.alarmArray = NSMutableArray(array: tempArray)
        } else {
            self.alarmArray = NSMutableArray()
        }
        
    }
    
    
    func save() {
        let alarmArrayData = NSKeyedArchiver.archivedData(withRootObject: self.alarmArray)
        kLXMUserDefaults.set(alarmArrayData, forKey: "alarmArray")
        kLXMUserDefaults.synchronize()
    }
    
}
