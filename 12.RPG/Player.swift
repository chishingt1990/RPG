//
//  Player.swift
//  12.RPG
//
//  Created by Shuang Wu on 22/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import Foundation

class Player: Character {
    
    private var _name = "Player"
    
    var name: String {
        get{
            return _name
        }
    }
    
    var inventory = [String]()
        
//    var inventory: [String] {
//        get{
//            return _inventory
//        }
//        set{
//            _inventory.append(newValue)
//        }
//    }
    
    convenience init (name: String, hp: Int, attackPwr: Int){
        self.init(startingHp: hp, attackPwr: attackPwr)
        _name = name
    }
    
}
