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
            
            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(LXMBaseViewController.handleLeftSwipeGesture))
            leftSwipeGesture.direction = .left
            leftSwipeGesture.numberOfTouchesRequired = kDefaultNumberOfTouchesRequired
            self.view.addGestureRecognizer(leftSwipeGesture)
            
            let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(LXMBaseViewController.handleRightSwipeGesture))
            rightSwipeGesture.direction = .right
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
    
    func handleLeftSwipeGesture(_ sender: UISwipeGestureRecognizer) -> Void {
        DLog("handleLeftSwipeGesture")
        let consoleViewController = LXMConsoleViewController()
        consoleViewController.hidesBottomBarWhenPushed = true
        self.present(consoleViewController, animated: true, completion: { () -> Void in
            
        })
        
    }
    
    func handleRightSwipeGesture(_ sender: UISwipeGestureRecognizer) -> Void {
        DLog("handleRightSwipeGesture")
    }

}

extension UIViewController {
    
    /**
     如果storyboardId跟类名相同，可以直接用这个方法
     */
    class func swift_loadFromStoryboard(_ storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName, storyboardId: nil)
    }

    /**
     类名跟storyboardId不一样时，需要传入storyboardName和storyboardId
     */
    class func swift_loadFromStoryboard(_ storyboardName: String, storyboardId: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName, storyboardId: storyboardId)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ storyboardName: String, storyboardId: String?) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        var identifier : String
        if let temp = storyboardId {
            identifier = temp
        } else {
            let tempString = NSStringFromClass(self.classForCoder())
            let tempArray = tempString.components(separatedBy: ".")
            identifier = tempArray.last!
        }
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return controller
    }
}





