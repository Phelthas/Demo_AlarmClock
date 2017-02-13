//
//  LXMConsoleViewController.swift
//  S_ojia
//
//  Created by luxiaoming on 15/12/15.
//  Copyright © 2015年 luxiaoming. All rights reserved.
//

var ConsoleInfoString = "log\n"

import UIKit

class LXMConsoleViewController: UIViewController {

    var textView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        self.textView = UITextView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: self.view.bounds.height - 20 - 49))
        self.textView.backgroundColor = UIColor.black
        self.textView.textColor = UIColor.green
        self.textView.isEditable = false
        self.textView.text = ConsoleInfoString
        self.view.addSubview(self.textView)
        self.textView.scrollRangeToVisible(NSMakeRange(self.textView.text.characters.count - 1, 1))

        
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(LXMConsoleViewController.handleRightSwipeGesture))
        rightSwipeGesture.numberOfTouchesRequired = 1
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - action
    
    func handleRightSwipeGesture(_ sender : UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true) { () -> Void in
            
        }
    }


}
