//
//  DevilWizard.swift
//  12.RPG
//
//  Created by Shuang Wu on 24/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import Foundation

class DevilWizard: Enemy {
    
    override var loot: [String] {
        return ["Magic Wand", "Dark Amulet", "Salted Pork"]
    }
    
    override var type: String {
        return "Devil Wizard"
    }
    
}
