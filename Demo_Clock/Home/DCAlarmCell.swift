//
//  DCAlarmCell.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/21.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

let DCAlarmCellIdentifier = "DCAlarmCell"
let kDCAlarmCellHeight = 60


class DCAlarmCell: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var alarmSwith: UISwitch!
    
    private var alarm: DCAlarm?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configWithAlarm(alarm: DCAlarm, indexPath: NSIndexPath) {
        self.alarm = alarm
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = alarm.alarmDate {
            self.dateLabel.text = dateFormatter.stringFromDate(date)
        }
        
        self.descriptionLabel.text = alarm.descriptionText
        self.alarmSwith.on = alarm.alarmOn
    }
    
    @IBAction func handleSwitchTapped(sender: UISwitch) {
        if let tempAlarm = self.alarm {
            if sender.on {
                tempAlarm.turnOnAlarm()
            } else {
                tempAlarm.turnOffAlarm()
            }
            DCAlarmManager.sharedInstance.save()
        }
        
        
    }
    
}
