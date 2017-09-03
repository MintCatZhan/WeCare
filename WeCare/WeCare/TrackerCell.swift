//
//  TrackerCell.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 28/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit

class TrackerCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
