//
//  LXMToolFunction.swift
//  S_ojia
//
//  Created by kook on 16/1/2.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import Foundation
import UIKit

func DLog(_ message: String, function: String = #function, line: Int = #line, file: String = #file) -> Void {

    #if DEBUG
        let tempArray = file.components(separatedBy: "/")
        let fileName = tempArray.last!
        let string = "file: \(fileName) line: \(line) func: \(function) log:\(message)"
        ConsoleInfoString += "\n" + string + "\n"
        NSLog(string)
        
    #endif
    
    
}

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}


/**
 截取当前屏幕的某个区域为一个image
 */
func imageFromScreenshotWithRect(_ rect: CGRect) -> UIImage? {
    if let window = UIApplication.shared.delegate?.window {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let targetRect = CGRect(x: -rect.origin.x, y: -rect.origin.y, width: kLXMScreenWidth, height: kLXMScreenHeight)
        window!.drawHierarchy(in: targetRect, afterScreenUpdates: false)
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
func timeDurationFromSeconds(_ seconds: TimeInterval) -> String {
    let datecomponents = DateComponents()
    if let date = Calendar.current.date(from: datecomponents) {
        let timeInterval = date.timeIntervalSince1970 + seconds
        let newDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: newDate)
    } else {
        return ""
    }
    
}

extension UIColor {
    
    static func LXMColor(_ r: Int, g: Int, b: Int, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
    
    static func LXMColorFromHex(_ hexRGBValue: Int) -> UIColor {
        let red = (hexRGBValue & 0xFF0000) >> 16
        let green = (hexRGBValue & 0xFF00) >> 8
        let blue = (hexRGBValue & 0xFF)
        return LXMColor(red, g: green, b: blue, a: 1.0)
    }
}






