//
//  DCClockSettingViewController.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/20.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//


import UIKit

class DCClockSettingViewController: LXMBaseViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    //button的tag为1-7，在xib中设置
    @IBOutlet weak var mondayButton: UIButton!
    
    @IBOutlet weak var tuesdayButton: UIButton!
    
    @IBOutlet weak var wednesdayButton: UIButton!
    
    @IBOutlet weak var thursdayButton: UIButton!
    
    @IBOutlet weak var fridayButton: UIButton!
    
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var sundayButton: UIButton!
    
    private var isAddingAlarm: Bool = false
    
    private var targetAlarm: DCAlarm!
    
    private var buttonArray: [UIButton] {
        return [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    }
    
    /// 从右向左依次是1-7，每一位表示一个button有没有选中，0x1111111表示全选，0x0000000表示一个都没选
    var selectedButtonTag = 0
    
    
    
    class func loadFromStroyboardWithTargetAlarm(alarm: DCAlarm?) -> DCClockSettingViewController {
        let viewController = DCClockSettingViewController.loadFromStoryboard("Main")
        if alarm == nil {
            viewController.isAddingAlarm = true
            viewController.targetAlarm = DCAlarm()
        } else {
            viewController.isAddingAlarm = false
            viewController.targetAlarm = alarm
        }
        return viewController
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isAddingAlarm {
            self.title = "添加闹钟"
        } else {
            self.title = "修改闹钟"
        }
        
        
        self.test()
        
        self.setupDefault()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - PrivateMethod
extension DCClockSettingViewController {
    func test() {
                
        let version = kLXMSystemVersion
        DLog("version is \(version)")
    }
    
    func setupDefault() {
        if let alarm = self.targetAlarm {
            if let date = alarm.alarmDate {
                self.datePicker.date = date
            } else {
                self.datePicker.date = NSDate()
            }
            self.selectedButtonTag = alarm.selectedDay
            for button in self.buttonArray {
                let selected = 1 << (button.tag - 1)
                button.selected = Bool(alarm.selectedDay & selected)
            }
            
        }
    }
}


// MARK: - Action
extension DCClockSettingViewController {
    
    
    @IBAction func handleCancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    @IBAction func handleConfirmButtonTapped(sender: UIButton) {
        let alarm = self.targetAlarm
        alarm.alarmDate = self.datePicker.date
        alarm.selectedDay = self.selectedButtonTag
        alarm.descriptionText = String(format: "%02x", self.selectedButtonTag)
        alarm.alarmOn = false
        alarm.identifier = alarm.alarmDate?.description
        if self.isAddingAlarm {
            DCAlarmManager.sharedInstance.alarmArray.addObject(alarm)
        }
        
        DCAlarmManager.sharedInstance.save()
        
        self.handleCancelButtonTapped(UIButton())
    }
    
    
    @IBAction func handleDayButtonTapped(sender: UIButton) {
        sender.selected = !sender.selected
        var resultTag = 0x0
        for button in self.buttonArray {
            let tag = Int(button.selected) << (button.tag - 1)
            resultTag = resultTag | tag
        }
        self.selectedButtonTag = resultTag
        
        let aaa = String(format: "%02x", resultTag)
        DLog("self.selectedButtonTag is \(aaa)")
    }
    
}


