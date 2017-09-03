//
//  DateTimeHandler.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 2/9/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit

class DateTimeHandler: NSObject {
    
    var dateTimeFormatString: String = "yyyy-MM-dd HH:mm:ss"
    var dateFormatString: String = "yyyy-MM-dd"
    var timeFormatString: String = "HH:mm:ss"
    
    //MARK: - Date and Time Handling
    
    func convertDateTimeStringToDateString(string: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormatString
        let getDate = formatter.date(from: string)
        
        formatter.dateFormat = dateFormatString
        let result = formatter.string(from: getDate!)
        return result
    }
    
    func convertDateToDateTimeString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormatString
        let result = formatter.string(from: date)
        return result
    }
    
    func convertDateTimeStringToTimeString(string: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormatString
        let getDate = formatter.date(from: string)
        
        formatter.dateFormat = timeFormatString
        let result = formatter.string(from: getDate!)
        return result
    }
    
    func convertDateTimeStringToDate(string: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormatString
        let result = formatter.date(from: string)
        return result!
    }


}
