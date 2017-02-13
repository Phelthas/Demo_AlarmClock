//
//  DCAlarm.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

class DCAlarm: NSObject, NSCoding {
    var alarmDate: Date?
    var descriptionText: String?
    var identifier: String?
    var selectedDay: Int = 0
    var alarmOn: Bool = false
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        alarmDate = aDecoder.decodeObject(forKey: "alarmDate") as? Date
        descriptionText = aDecoder.decodeObject(forKey: "descriptionText") as? String
        identifier = aDecoder.decodeObject(forKey: "identifier") as? String
        selectedDay = aDecoder.decodeInteger(forKey: "selectedDay")
        alarmOn = aDecoder.decodeBool(forKey: "alarmOn") as Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(alarmDate, forKey: "alarmDate")
        aCoder.encode(descriptionText, forKey: "descriptionText")
        aCoder.encode(identifier, forKey: "identifier")
        aCoder.encode(selectedDay, forKey: "selectedDay")
        aCoder.encode(alarmOn, forKey: "alarmOn")
    }
    
    
    func turnOnAlarm() {
        if let tempDate = self.alarmDate {
            if self.selectedDay == 0 {
                self.addLocalNotificationForDate(tempDate, selectedDay: 0)
            } else {
                for i in 1...7 {
                    if ((1 << (i - 1)) & self.selectedDay) != 0 {
                        self.addLocalNotificationForDate(tempDate, selectedDay: i)
                    }
                }
                
            }
            
            self.alarmOn = true
        }
        DLog("after set localNotification is \n \(UIApplication.shared.scheduledLocalNotifications)")
    }
    
    func turnOffAlarm() {
        if self.alarmOn == false {
            return
        }
        self.alarmOn = false
        if let tempArray = UIApplication.shared.scheduledLocalNotifications {
            for tempNotification in tempArray {
                print("it is \(tempNotification.userInfo!["identifier"])")
                if let identfier = tempNotification.userInfo!["identifier"] as? String {
                    if identfier == self.identifier! {
                        UIApplication.shared.cancelLocalNotification(tempNotification)
                    }
                    
                }
            }
        }
        DLog("after set localNotification is \n \(UIApplication.shared.scheduledLocalNotifications)")
    }
    
    
}

// MARK: - PrivateMethod
fileprivate extension DCAlarm {
    
    fileprivate func addLocalNotificationForDate(_ date: Date, selectedDay: NSInteger) {
        //selectedDay == 0则认为是只响一次的闹钟
        let calendar = Calendar.current
        let type: NSCalendar.Unit = [NSCalendar.Unit.year , NSCalendar.Unit.month , NSCalendar.Unit.day , NSCalendar.Unit.hour , NSCalendar.Unit.minute , NSCalendar.Unit.second , NSCalendar.Unit.weekday]
        var dateComponents = (calendar as NSCalendar).components(type, from: date)
        dateComponents.second = 0
        let newDate = calendar.date(from: dateComponents)
        var diffComponents = DateComponents()
        var newWeekDay = selectedDay + 1//苹果默认周日是1，依次往后排；而app里定义的是周一是1，依次往后排
        if newWeekDay == 8 {
            newWeekDay = 1
        }
        diffComponents.day = newWeekDay - dateComponents.weekday!//计算出所选的周几与当前时间的间隔
        let fireDate = (calendar as NSCalendar).date(byAdding: diffComponents, to: newDate!, options: .wrapComponents)
        let localNotification = UILocalNotification()
        localNotification.fireDate = fireDate
        let repeateInterval: NSCalendar.Unit = [.NSWeekCalendarUnit]//注意这个选项才是每周。。。
        localNotification.repeatInterval = selectedDay == 0 ? NSCalendar.Unit(rawValue: 0) : repeateInterval
        localNotification.timeZone = TimeZone.current
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = "本地推送内容"
        localNotification.userInfo = [
            "identifier" : self.identifier!, //注意，这里不同日子同一时刻的通知公用一个identifier
            "fireDay" : fireDate!]
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
}




