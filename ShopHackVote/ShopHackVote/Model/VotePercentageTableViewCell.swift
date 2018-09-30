//
//  VotePercentageTableViewCell.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 30/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

class VotePercentageTableViewCell: UITableViewCell {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var percentageSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
