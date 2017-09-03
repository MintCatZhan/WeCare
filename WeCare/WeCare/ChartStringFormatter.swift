//
//  ChartStringFormatter.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 1/9/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit
import Charts
import Foundation
class ChartStringFormatter: NSObject, IAxisValueFormatter {
    
    var nameValues = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: nameValues[Int(value)])
    }
}
