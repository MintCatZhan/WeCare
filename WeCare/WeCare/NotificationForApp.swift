//
//  NotificationForApp.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 17/9/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationForApp: NSObject {
    func over8HoursNofitication(){
        let content = UNMutableNotificationContent()
        content.title = "Over 8 Hours Working"
        content.subtitle = ""
        content.body = "You are working over 8 hours!!!"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
