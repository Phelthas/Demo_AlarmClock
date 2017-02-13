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
    
    fileprivate var isAddingAlarm: Bool = false
    
    fileprivate var targetAlarm: DCAlarm!
    
    fileprivate var buttonArray: [UIButton] {
        return [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    }
    
    /// 从右向左依次是1-7，每一位表示一个button有没有选中，0x1111111表示全选，0x0000000表示一个都没选
    var selectedButtonTag = 0
    
    
    
    class func loadFromStroyboardWithTargetAlarm(_ alarm: DCAlarm?) -> DCClockSettingViewController {
        let viewController = DCClockSettingViewController.swift_loadFromStoryboard("Main")
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
                self.datePicker.date = date as Date
            } else {
                self.datePicker.date = Date()
            }
            self.selectedButtonTag = alarm.selectedDay
            for button in self.buttonArray {
                let selected = 1 << (button.tag - 1)
                button.isSelected = (alarm.selectedDay & selected) != 0
            }
            
        }
    }
}


// MARK: - Action
extension DCClockSettingViewController {
    
    
    @IBAction func handleCancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) { () -> Void in
            
        }
    }
    
    @IBAction func handleConfirmButtonTapped(_ sender: UIButton) {
        if let alarm = self.targetAlarm {
            alarm.alarmDate = self.datePicker.date
            alarm.selectedDay = self.selectedButtonTag
            alarm.descriptionText = String(format: "%02x", self.selectedButtonTag)
            alarm.alarmOn = false
            alarm.identifier = alarm.alarmDate?.description
            if self.isAddingAlarm {
                DCAlarmManager.sharedInstance.alarmArray.append(alarm)
            }
            
            DCAlarmManager.sharedInstance.save()
            
            self.handleCancelButtonTapped(UIButton())
        } else {
            DLog("there is something wrong, 理论上alarm不会为空的")
        }
        
        
    }
    
    
    @IBAction func handleDayButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        var resultTag = 0x0
        for button in self.buttonArray {
            let selected: Int = button.isSelected ? 1 : 0
            let tag = selected << (button.tag - 1)
            resultTag = resultTag | tag
        }
        self.selectedButtonTag = resultTag
        
        let aaa = String(format: "%02x", resultTag)
        DLog("self.selectedButtonTag is \(aaa)")
    }
    
}


