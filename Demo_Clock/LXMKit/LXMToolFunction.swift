//
//  LXMToolFunction.swift
//  S_ojia
//
//  Created by kook on 16/1/2.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import Foundation
import UIKit

func DLog(message: String, function: String = #function, line: Int = #line, file: String = #file) -> Void {

    #if DEBUG
        let tempArray = file.componentsSeparatedByString("/")
        let fileName = tempArray.last!
        let string = "file: \(fileName) line: \(line) func: \(function) log:\(message)"
        ConsoleInfoString += "\n" + string + "\n"
        NSLog(string)
        
    #endif
    
    
}

func delay(delay: Double, closure: ()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}


/**
 截取当前屏幕的某个区域为一个image
 */
func imageFromScreenshotWithRect(rect: CGRect) -> UIImage? {
    if let window = UIApplication.sharedApplication().delegate?.window {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let targetRect = CGRectMake(-rect.origin.x, -rect.origin.y, kLXMScreenWidth, kLXMScreenHeight)
        window!.drawViewHierarchyInRect(targetRect, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    } else {
        return nil
    }
}

/**
 把秒转换为时分秒的格式
 */
func timeDurationFromSeconds(seconds: NSTimeInterval) -> String {
    let datecomponents = NSDateComponents()
    if let date = NSCalendar.currentCalendar().dateFromComponents(datecomponents) {
        let timeInterval = date.timeIntervalSince1970 + seconds
        let newDate = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.stringFromDate(newDate)
    } else {
        return ""
    }
    
}

extension UIColor {
    
    static func LXMColor(r: Int, g: Int, b: Int, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
    
    static func LXMColorFromHex(hexRGBValue: Int) -> UIColor {
        let red = (hexRGBValue & 0xFF0000) >> 16
        let green = (hexRGBValue & 0xFF00) >> 8
        let blue = (hexRGBValue & 0xFF)
        return LXMColor(red, g: green, b: blue, a: 1.0)
    }
}






