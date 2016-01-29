//
//  LXMBaseView.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

class LXMBaseView: UIView {

    

}


extension UIView {
    
    class func nib() -> UINib {
        let tempString = NSStringFromClass(self.classForCoder())
        let tempArray = tempString.componentsSeparatedByString(".")
        let name = tempArray.last!
        return UINib(nibName: name, bundle: nil)
    }
    
    class func loadFromNib() -> Self {
        return loadFromNibHelper()
    }
    
    private class func loadFromNibHelper<T>() -> T {
        let tempString = NSStringFromClass(self.classForCoder())
        let tempArray = tempString.componentsSeparatedByString(".")
        let name = tempArray.last!
        let objectArray = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        return objectArray.last as! T
    }
}