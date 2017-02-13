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
    
    override func viewDidAppear(_ animated: Bool) {
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
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DCHomeViewController.handleAddItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = addItem
    }
    
}

// MARK: - Action
extension DCHomeViewController {
    func handleAddItemTapped(_ sender: UIBarButtonItem) {
        let clockSettingViewController = DCClockSettingViewController.loadFromStroyboardWithTargetAlarm(nil)
        clockSettingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.present(clockSettingViewController, animated: true, completion: { () -> Void in
            
        })
    }
}


extension DCHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return DCAlarmManager.sharedInstance.alarmArray.count
        if ((self.dataArray?.count) != nil) {
            return (self.dataArray?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DCAlarmCellIdentifier) as! DCAlarmCell
        if let alarm = self.dataArray?.object(at: (indexPath as NSIndexPath).row) as? DCAlarm {
            cell.configWithAlarm(alarm, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.dataArray!.object(at: (indexPath as NSIndexPath).row)
        self.dataArray?.remove(item)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.reloadData()
        DCAlarmManager.sharedInstance.save()
    }
    
}

extension DCHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let alarm = self.dataArray?.object(at: (indexPath as NSIndexPath).row) as? DCAlarm {
            let clockSettingViewController = DCClockSettingViewController.loadFromStroyboardWithTargetAlarm(alarm)
            clockSettingViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.present(clockSettingViewController, animated: true, completion: { () -> Void in
                
            })
        }
    }
}
