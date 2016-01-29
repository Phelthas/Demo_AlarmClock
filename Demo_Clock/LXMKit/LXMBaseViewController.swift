//
//  LXMBaseViewController.swift
//  S_ojia
//
//  Created by luxiaoming on 15/12/15.
//  Copyright © 2015年 luxiaoming. All rights reserved.
//

let kDefaultNumberOfTouchesRequired = 2

import UIKit

class LXMBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()


        #if DEBUG
            
            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: "handleLeftSwipeGesture:")
            leftSwipeGesture.direction = .Left
            leftSwipeGesture.numberOfTouchesRequired = kDefaultNumberOfTouchesRequired
            self.view.addGestureRecognizer(leftSwipeGesture)
            
            let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: "handleRightSwipeGesture:")
            rightSwipeGesture.direction = .Right
            rightSwipeGesture.numberOfTouchesRequired = kDefaultNumberOfTouchesRequired
            self.view.addGestureRecognizer(rightSwipeGesture)
            
        #endif
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - Action
extension LXMBaseViewController {
    
    func handleLeftSwipeGesture(sender: UISwipeGestureRecognizer) -> Void {
        DLog("handleLeftSwipeGesture")
        let consoleViewController = LXMConsoleViewController()
        consoleViewController.hidesBottomBarWhenPushed = true
        self.presentViewController(consoleViewController, animated: true, completion: { () -> Void in
            
        })
        
    }
    
    func handleRightSwipeGesture(sender: UISwipeGestureRecognizer) -> Void {
        DLog("handleRightSwipeGesture")
    }

}

extension UIViewController {
    
    class func loadFromStoryboard(storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName, storyboardId: nil)
    }

    class func loadFromStoryboard(storyboardName: String, storyboardId: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName, storyboardId: storyboardId)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String?) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        var identifier : String
        if let temp = storyboardId {
            identifier = temp
        } else {
            let tempString = NSStringFromClass(self.classForCoder())
            let tempArray = tempString.componentsSeparatedByString(".")
            identifier = tempArray.last!
        }
        let controller = storyboard.instantiateViewControllerWithIdentifier(identifier) as! T
        return controller
    }
}





