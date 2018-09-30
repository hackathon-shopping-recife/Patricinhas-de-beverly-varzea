//
//  SelfSizedTableView.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 30/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {

    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }

}
