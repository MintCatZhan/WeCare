//
//  HoursTracking+CoreDataProperties.swift
//  
//
//  Created by Nguyen Dinh Thang on 14/9/17.
//
//

import Foundation
import CoreData


extension HoursTracking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoursTracking> {
        return NSFetchRequest<HoursTracking>(entityName: "HoursTracking")
    }

    @NSManaged public var from: String?
    @NSManaged public var id: Int32
    @NSManaged public var to: String?

}
