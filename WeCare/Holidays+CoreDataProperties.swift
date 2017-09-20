//
//  Holidays+CoreDataProperties.swift
//  
//
//  Created by Nguyen Dinh Thang on 18/9/17.
//
//

import Foundation
import CoreData


extension Holidays {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Holidays> {
        return NSFetchRequest<Holidays>(entityName: "Holidays")
    }

    @NSManaged public var state: String?
    @NSManaged public var date: String?
    @NSManaged public var name: String?

}
