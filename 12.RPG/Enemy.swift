//
//  Enemy.swift
//  12.RPG
//
//  Created by Shuang Wu on 24/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import Foundation

class Enemy: Character {
    
    var loot: [String] {
        return ["Rusty Dagger", "Cracked Buckler"]
    }
    
    var type: String {
        return "Grunt"
    }
    
    //not sure if will always return a loot, so put a question mark after the string
    func dropLoot () -> String? {
        if !isAlive {
            //Casts loot count (which is an integer, representing length of the loot array), which is then casted into a UInt with the UInt32 keyword. Then arc4random_uniform can do a random number of UInt32, which results in a randomized UInt32, and at last it is casted back as an Integer with the Int keyword
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            //returns the randomized loot (remember rand is an integer)
            return loot[rand]
        }
        return nil
    }
    
}
