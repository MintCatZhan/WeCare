//
//  HoursTracking+CoreDataProperties.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 29/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import Foundation
import CoreData


extension HoursTracking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoursTracking> {
        return NSFetchRequest<HoursTracking>(entityName: "HoursTracking")
    }

    @NSManaged public var from: String?
    @NSManaged public var to: String?
    @NSManaged public var id: Int32
    @NSManaged public var fromDate: String?
    @NSManaged public var toDate: String?

}
