//
//  Kymera.swift
//  12.RPG
//
//  Created by Shuang Wu on 24/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import Foundation

class Kymera: Enemy {
    
    let immune_max = 15
    
    override var loot: [String] {
        return ["Tough Hide", "Kymera Venom", "Rare Trident"]
    }
    
    override var type: String {
        return "Kymera"
    }
    
    override func attemptAttack(attackPwr: Int) -> Bool {
        if attackPwr >= immune_max {
            return super.attemptAttack(attackPwr: attackPwr)
        } else {
            return false
        }
    }
    
}
