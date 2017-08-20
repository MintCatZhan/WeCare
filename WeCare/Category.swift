//
//  Category.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 20/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit

class Category: NSObject {
    var name: String?
    var image: String?
    
    override init() {
        self.name = "Unknown"
        self.image = "Unkown"
    }
    
    init(name: String!, image: String!) {
        self.name = name
        self.image = image
    }
}
