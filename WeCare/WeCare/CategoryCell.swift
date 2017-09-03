//
//  CategoryCell.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 16/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var imageCategoryView: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
