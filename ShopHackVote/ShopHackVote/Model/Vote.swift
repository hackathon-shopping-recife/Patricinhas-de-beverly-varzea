//
//  Vote.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 29/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

class Vote {
    
    var title: String?
    var banner: UIImage?
    var competidores: (Competidor, Competidor)?
    var voted = false
    
    init(titulo: String, imagem: UIImage, competidor1: Competidor, competidor2: Competidor) {
        self.title = titulo
        self.banner = imagem
        self.competidores = (competidor1, competidor2)
        
    }
    
}

class Competidor {
    var name: String?
    var description: String?
    var tags: [String]?
    
    init(nome: String, descrip: String?, tags: [String]?) {
        self.name = nome
        self.description = descrip
        self.tags = tags
    }
}
