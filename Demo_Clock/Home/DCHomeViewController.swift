//
//  DCHomeViewController.swift
//  Demo_Clock
//
//  Created by luxiaoming on 16/1/20.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

import UIKit

class DCHomeViewController: LXMBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "闹钟"
        
        self.setupTableView()
        self.setupNavigationBar()
        
        self.dataArray = DCAlarmManager.sharedInstance.alarmArray //swift的数组是struct，是值类型，写的时候要特别注意
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }

}

// MARK: - PrivateMethod
extension DCHomeViewController {
    
    func setupTableView() {
        self.tableView.tableFooterView = UIView()
        
    }
    
    func setupNavigationBar() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "handleAddItemTapped:")
        self.navigationItem.rightBarButtonItem = addItem
    }
    
}

// MARK: - Action
extension DCHomeViewController {
    func handleAddItemTapped(sender: UIBarButtonItem) {
        let clockSettingViewController = DCClockSettingViewController.loadFromStroyboardWithTargetAlarm(nil)
        clockSettingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.presentViewController(clockSettingViewController, animated: true, completion: { () -> Void in
            
        })
    }
}


extension DCHomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return DCAlarmManager.sharedInstance.alarmArray.count
        if ((self.dataArray?.count) != nil) {
            return (self.dataArray?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DCAlarmCellIdentifier) as! DCAlarmCell
        if let alarm = self.dataArray?.objectAtIndex(indexPath.row) as? DCAlarm {
            cell.configWithAlarm(alarm, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.dataArray!.objectAtIndex(indexPath.row)
        self.dataArray?.removeObject(item)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        tableView.reloadData()
        DCAlarmManager.sharedInstance.save()
    }
    
}

extension DCHomeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let alarm = self.dataArray?.objectAtIndex(indexPath.row) as? DCAlarm {
            let clockSettingViewController = DCClockSettingViewController.loadFromStroyboardWithTargetAlarm(alarm)
            clockSettingViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.presentViewController(clockSettingViewController, animated: true, completion: { () -> Void in
                
            })
        }
    }
}
