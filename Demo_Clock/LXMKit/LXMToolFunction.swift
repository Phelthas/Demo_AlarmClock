//
//  LXMToolFunction.swift
//  S_ojia
//
//  Created by kook on 16/1/2.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import Foundation
import UIKit

func DLog(message: String, function: String = __FUNCTION__, line: Int = __LINE__, file: String = __FILE__) -> Void {

    #if DEBUG
        let tempArray = file.componentsSeparatedByString("/")
        let fileName = tempArray.last!
        let string = "file: \(fileName) line: \(line) func: \(function) log:\(message)"
        ConsoleInfoString += "\n" + string + "\n"
        NSLog(string)
        
    #endif
    
    
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
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






