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
    
    //加swift前缀是因为和OC混编的时候，有可能因为方法名一样导致调用了OC的函数而不是swift的
    
    class func swift_nib() -> UINib {
        let tempString = NSStringFromClass(self.classForCoder())
        let tempArray = tempString.components(separatedBy: ".")
        let name = tempArray.last!
        return UINib(nibName: name, bundle: nil)
    }
    
    class func swift_loadFromNib() -> Self {
        return loadFromNibHelper()
    }
    
    fileprivate class func loadFromNibHelper<T>() -> T {
        let tempString = NSStringFromClass(self.classForCoder())
        let tempArray = tempString.components(separatedBy: ".")
        let name = tempArray.last!
        let objectArray = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return objectArray!.last as! T
    }
}
