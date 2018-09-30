//
//  VoteDescriptionTableViewCell.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 30/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import FaveButton

class VoteDescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var voteButton: FaveButton!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.isUserInteractionEnabled = true
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
