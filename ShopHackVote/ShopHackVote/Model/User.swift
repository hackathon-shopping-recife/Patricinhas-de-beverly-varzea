//
//  User.swift
//  ShopHackVote
//
//  Created by Ian Manor on 30/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation
//import Firebase/Database

class User {
    static let shared = User()
    
    var profiles: [String: (Bool, Int)] = [
        "Cult": (false, 0),
        "Família": (false, 0),
        "Gastronomia": (false, 0),
        "Shopper": (false, 0),
        "Teen": (false, 0),
        "Kids": (false, 0),
        "Fitness": (false, 0),
    ]
}
