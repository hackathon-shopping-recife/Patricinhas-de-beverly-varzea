//
//  Expandable.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 29/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

protocol Expandable {
    func collapse()
    func expand(in collectionView: UICollectionView)
}
