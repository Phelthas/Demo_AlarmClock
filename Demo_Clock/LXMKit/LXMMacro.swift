//
//  LXMMacro.swift
//  S_ojia
//
//  Created by kook on 16/1/2.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import Foundation
import UIKit


let kLXMScreenBounds = UIScreen.main.bounds
let kLXMUserDefaults = UserDefaults.standard
let kLXMNotificationCenter = NotificationCenter.default
let kLXMFileManager = FileManager.default
let kLXMScreenWidth: CGFloat = kLXMScreenBounds.width
let kLXMScreenHeight: CGFloat = kLXMScreenBounds.height

/// 这个只取大版本号，比如7，7.1，7.2.1都返回7
let kLXMSystemVersion = Int(UIDevice.current.systemVersion.components(separatedBy: ".").first!)!

let kLXMStatusBarHeight: CGFloat = 20
let kLXMNavigationBarHeight: CGFloat = 44
let kLXMTopHeight: CGFloat = 64
let kLXMTabBarHeight: CGFloat = 49


