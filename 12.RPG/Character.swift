//
//  Character.swift
//  12.RPG
//
//  Created by Shuang Wu on 22/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import Foundation


//This is the base class for Player and Enemy class. Regardless of character type, all characters will have hp, attackpwr as a initializer parameter.

class Character {
    //data hide, carefully protects data with private var
    private var _hp: Int = 100
    private var _attackPwr: Int = 30
    
    //these get blocks allows when others want to access attackPwr and hp, but will not allow them to change (no SET blocks)
    var attackPwr: Int {
        get {
            return _attackPwr
        }
        set {
            _attackPwr = newValue
        }
    }
    
    var hp: Int {
        get{
            return _hp
        }
        set {
                _hp = newValue
        }
    }
    
    //this variable returns true or false dependent on the computed result
    var isAlive: Bool {
        get {
            if hp <= 0{
                return false
            } else {
                return true
            }
            
        }
    }
    
    //initializer, assigns hp and pwr to the hidden variables
    init (startingHp: Int, attackPwr: Int){
        self._hp = startingHp
        self._attackPwr = attackPwr
    }
    
    //attack function, returns a bool (true/false) dependent on whether or not the attempted attack is successful or not
    func attemptAttack (attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        return true
    }
    
}
