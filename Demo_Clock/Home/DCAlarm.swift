//
//  DCAlarm.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

class DCAlarm: NSObject, NSCoding {
    var alarmDate: NSDate?
    var descriptionText: String?
    var identifier: String?
    var selectedDay: Int = 0
    var alarmOn: Bool = false
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        alarmDate = aDecoder.decodeObjectForKey("alarmDate") as? NSDate
        descriptionText = aDecoder.decodeObjectForKey("descriptionText") as? String
        identifier = aDecoder.decodeObjectForKey("identifier") as? String
        selectedDay = (aDecoder.decodeObjectForKey("selectedDay") as! NSNumber).integerValue
        alarmOn = aDecoder.decodeBoolForKey("alarmOn") as Bool
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(alarmDate, forKey: "alarmDate")
        aCoder.encodeObject(descriptionText, forKey: "descriptionText")
        aCoder.encodeObject(identifier, forKey: "identifier")
        aCoder.encodeObject(NSNumber(integer: selectedDay), forKey: "selectedDay")
        aCoder.encodeBool(alarmOn, forKey: "alarmOn")
    }
    
    
    func turnOnAlarm() {
        if let tempDate = self.alarmDate {
            if self.selectedDay == 0 {
                self.addLocalNotificationForDate(tempDate, selectedDay: 0)
            } else {
                for (var i = 1; i <= 7; i++) {
                    if Bool((1 << (i - 1)) & self.selectedDay) {
                        self.addLocalNotificationForDate(tempDate, selectedDay: i)
                    }
                    
                }
            }
            
            self.alarmOn = true
        }
        DLog("after set localNotification is \n \(UIApplication.sharedApplication().scheduledLocalNotifications)")
    }
    
    func turnOffAlarm() {
        if self.alarmOn == false {
            return
        }
        self.alarmOn = false
        if let tempArray = UIApplication.sharedApplication().scheduledLocalNotifications {
            for tempNotification in tempArray {
                print("it is \(tempNotification.userInfo!["identifier"])")
                if let identfier = tempNotification.userInfo!["identifier"] as? String {
                    if identfier == self.identifier! {
                        UIApplication.sharedApplication().cancelLocalNotification(tempNotification)
                    }
                    
                }
            }
        }
    DLog("after set localNotification is \n \(UIApplication.sharedApplication().scheduledLocalNotifications)")
    }
    
    
}

// MARK: - PrivateMethod
extension DCAlarm {
    
    private func addLocalNotificationForDate(date: NSDate, selectedDay: NSInteger) {
        //selectedDay == 0则认为是只响一次的闹钟
        let calendar = NSCalendar.currentCalendar()
        let type: NSCalendarUnit = [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute , NSCalendarUnit.Second , NSCalendarUnit.Weekday]
        let dateComponents = calendar.components(type, fromDate: date)
        dateComponents.second = 0
        let newDate = calendar.dateFromComponents(dateComponents)
        let diffComponents = NSDateComponents()
        var newWeekDay = selectedDay + 1//苹果默认周日是1，依次往后排；而app里定义的是周一是1，依次往后排
        if newWeekDay == 8 {
            newWeekDay = 1
        }
        diffComponents.day = newWeekDay - dateComponents.weekday//计算出所选的周几与当前时间的间隔
        let fireDate = calendar.dateByAddingComponents(diffComponents, toDate: newDate!, options: .WrapComponents)
        let localNotification = UILocalNotification()
        localNotification.fireDate = fireDate
        let repeateInterval: NSCalendarUnit = [.NSWeekCalendarUnit]//注意这个选项才是每周。。。
        localNotification.repeatInterval = selectedDay == 0 ? NSCalendarUnit(rawValue: 0) : repeateInterval
        localNotification.timeZone = NSTimeZone.systemTimeZone()
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = "本地推送内容"
        localNotification.userInfo = [
            "identifier" : self.identifier!, //注意，这里不同日子同一时刻的通知公用一个identifier
            "fireDay" : fireDate!]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
}




