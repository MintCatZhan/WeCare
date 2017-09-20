////
////  HolidaysData.swift
////  WeCare
////
////  Created by Nguyen Dinh Thang on 18/9/17.
////  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
////
//
//import UIKit
//import CoreData
//import Foundation
//
//class HolidaysData: NSObject {
//    
//    var getFetchEntityName: String = "Holidays"
//    
//    var managedObjectContext: NSManagedObjectContext
//    
////    required init?(coder aDecoder: NSCoder) {
////        let appDelegate = UIApplication.shared.delegate as? AppDelegate
////        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
////        init(coder: aDecoder)
////    }
//    
//    func setHolidayData(){
//        
//        //NEW YEARS DAY
//        var data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-01-01"
//        data?.name = "New Years Day"
//        
//        //New Year Holiday
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-01-02"
//        data?.name = "New Years Day"
//        
//        //AUSTRALIA DAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-01-26"
//        data?.name = "Australia Day"
//        
//        //LABOUR DAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-03-06"
//        data?.name = "Labour Day"
//        
//        //HOLI
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-03-13"
//        data?.name = "Adelaide Cup"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-03-13"
//        data?.name = "Canberra Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-03-13"
//        data?.name = "Labour Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-03-13"
//        data?.name = "Labour Day"
//        
//        
//        //GOOD FRIDAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-04-14"
//        data?.name = "Good Friday"
//        
//        //EASTER SATURDAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-04-15"
//        data?.name = "Easter Saturday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-04-15"
//        data?.name = "Easter Saturday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-04-15"
//        data?.name = "Easter Saturday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-04-15"
//        data?.name = "Easter Saturday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-04-15"
//        data?.name = "Easter Saturday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-04-15"
//        data?.name = "Easter Saturday"
//        
//        //EASTER SUNDAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-04-16"
//        data?.name = "Easter Sunday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-04-16"
//        data?.name = "Easter Sunday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-04-16"
//        data?.name = "Easter Sunday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-04-16"
//        data?.name = "Easter Sunday"
//        
//        //EASTER MONDAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-04-17"
//        data?.name = "Easter Monday"
//        
//        //EASTER TUESDAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-04-18"
//        data?.name = "Easter Tuesday"
//        
//        //ANZAC DAY
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-04-25"
//        data?.name = "ANZAC Day"
//        
//        //Labour Day
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-05-01"
//        data?.name = "Labour Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-05-01"
//        data?.name = "Labour Day"
//        
//        //Western Australia Day
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-06-05"
//        data?.name = "Western Australia Day"
//        
//        //Queen's Birthday
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-06-12"
//        data?.name = "Queen's Birthday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-06-12"
//        data?.name = "Queen's Birthday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-06-12"
//        data?.name = "Queen's Birthday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-06-12"
//        data?.name = "Queen's Birthday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-06-12"
//        data?.name = "Queen's Birthday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-06-12"
//        data?.name = "Queen's Birthday"
//        
//        //Holiday
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-08-07"
//        data?.name = "Picnic Day"
//        
//        //September 25
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-09-25"
//        data?.name = "Family & Community Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = ""
//        data?.date = "2017-09-25"
//        data?.name = "Queens Birthday"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-09-29"
//        data?.name = "Grand Final Eve"
//        
//        //Labour day
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-10-02"
//        data?.name = "Labour Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-10-02"
//        data?.name = "Labour Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-10-02"
//        data?.name = "Labour Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-10-02"
//        data?.name = "Queen's Birthday"
//        
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-11-07"
//        data?.name = "Melbourne Cup Day"
//        
//        //Christmas Day
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-12-25"
//        data?.name = "Christmas Day"
//        
//        //Boxing day
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NSW"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "QLD"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "SA"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "TAS"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "VIC"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "WA"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "ACT"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? Holidays
//        data?.state = "NT"
//        data?.date = "2017-12-26"
//        data?.name = "Boxing Day"
//        
//        
//        do{
//            try self.managedObjectContext.save()
//        }
//        catch let error{
//            print("Could not save: \(error)")
//        }
//    }
//    
//    
//
//    
//}
