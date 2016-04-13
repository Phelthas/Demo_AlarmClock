//
//  LXMMacro.swift
//  S_ojia
//
//  Created by kook on 16/1/2.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import Foundation
import UIKit


let kLXMScreenBounds = UIScreen.mainScreen().bounds
let kLXMUserDefaults = NSUserDefaults.standardUserDefaults()
let kLXMNotificationCenter = NSNotificationCenter.defaultCenter()
let kLXMFileManager = NSFileManager.defaultManager()
let kLXMScreenWidth: CGFloat = CGRectGetWidth(kLXMScreenBounds)
let kLXMScreenHeight: CGFloat = CGRectGetHeight(kLXMScreenBounds)

/// 这个只取大版本号，比如7，7.1，7.2.1都返回7
let kLXMSystemVersion = Int(UIDevice.currentDevice().systemVersion.componentsSeparatedByString(".").first!)!

let kLXMStatusBarHeight: CGFloat = 20
let kLXMNavigationBarHeight: CGFloat = 44
let kLXMTopHeight: CGFloat = 64
let kLXMTabBarHeight: CGFloat = 49


