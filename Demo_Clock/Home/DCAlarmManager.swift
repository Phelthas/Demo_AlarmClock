//
//  DCAlarmManager.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

class DCAlarmManager {
    var alarmArray: [DCAlarm]
    static let sharedInstance = DCAlarmManager()
    
    private let kDCAlarmArraySavedKey = "kDCAlarmArraySavedKey"
    
    fileprivate init() {
        if let alarmArrayData = kLXMUserDefaults.object(forKey: kDCAlarmArraySavedKey) as? Data,
            let tempArray = NSKeyedUnarchiver.unarchiveObject(with: alarmArrayData) as? [DCAlarm] {
            alarmArray = tempArray
        } else {
            alarmArray = [DCAlarm]()
        }
    }
    
    
    func save() {
        let alarmArrayData = NSKeyedArchiver.archivedData(withRootObject: self.alarmArray)
        kLXMUserDefaults.set(alarmArrayData, forKey: kDCAlarmArraySavedKey)
        kLXMUserDefaults.synchronize()
    }
    
}
