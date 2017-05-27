//
//  ViewController.swift
//  12.RPG
//
//  Created by Shuang Wu on 22/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var printLabel: UILabel!
    @IBOutlet weak var playerHPLabel: UILabel!
    @IBOutlet weak var enemyHPLabel:UILabel!
    @IBOutlet weak var enemyPic: UIImageView!
    @IBOutlet weak var playerPic: UIImageView!
    @IBOutlet weak var chest: UIButton!
    @IBOutlet weak var killCountLabel: UILabel!
    @IBOutlet weak var attack: UIButton!
    @IBOutlet weak var inventory: UIButton!
    @IBOutlet weak var restartIcon: UIButton!
    
    var attackPwrPlus = 0
    var killCount = 0
    var inventoryCount = 0
    var hpTemp = 0
    var attackPwrTemp = 0
    var typeTemp = 0
    var player: Player!
    var enemy: Enemy!
    func randomNumber () -> Int {
        return Int(arc4random_uniform(3))
    }
    func generateStats(){
        let randHp = randomNumber()
        if randHp == 0 {
            hpTemp = 60
        } else if randHp == 1 {
            hpTemp = 100
        } else {
            hpTemp = 140
        }
        generateAttackPwr()
    }
    func generateAttackPwr (){
        let randAttackPwr = randomNumber()
        if randAttackPwr == 0 {
            attackPwrTemp = 10
        } else if randAttackPwr == 1 {
            attackPwrTemp = 20
        } else {
            attackPwrTemp = 30
        }
    }
    func generateEnemy() {
        let randtype = randomNumber()
        generateStats()
        if randtype == 0 {
            enemy = Enemy(startingHp: hpTemp, attackPwr: attackPwrTemp)
        } else if randtype == 1 {
            enemy = Kymera(startingHp: hpTemp, attackPwr: attackPwrTemp)
        } else {
            enemy = DevilWizard(startingHp: hpTemp, attackPwr: attackPwrTemp)
        }
    }
    func killCountPlus() {
        killCount += 1
        killCountLabel.text = "Kill Count: \(killCount)"
    }
    
    func restartGame(){
        chest.isHidden = true
        restartUnhide()
        inventory.isHidden = true
        generateStats()
        killCount = 0
        killCountLabel.text = "Kill Count: \(killCount)"
        inventoryCount = 0
        hpTemp *= randomNumber()
        hpTemp += 50
        player = Player(name: "Chi Shing",hp: hpTemp, attackPwr: attackPwrTemp)
        generateEnemy()
        updateHP()
        printLabel.text = "\(player.name) faces a new \(enemy.type)!"
    }
    func diedHide(){
        playerPic.isHidden = true
        enemyPic.isHidden = true
        attack.isHidden = true
        playerHPLabel.isHidden = true
        enemyHPLabel.isHidden = true
        inventory.isHidden = true
        chest.isHidden = true
        restartIcon.isHidden = false
    }
    func restartUnhide(){
        playerPic.isHidden = false
        enemyPic.isHidden = false
        attack.isHidden = false
        playerHPLabel.isHidden = false
        enemyHPLabel.isHidden = false
        restartIcon.isHidden = true
    }
    func hideButtons(){
        attack.isHidden = true
        inventory.isHidden = true
    }
    func unhideButtons(){
        attack.isHidden = false
        inventory.isHidden = false
    }
    func updateHP(){
        playerHPLabel.text = "\(player.hp) HP"
        enemyHPLabel.text = "\(enemy.hp) HP"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        restartGame()
    }
    @IBAction func takeLoot(sender: AnyObject){
        player.inventory.append(enemy.dropLoot()!)
        unhideButtons()
        generateEnemy()
        updateHP()
        printLabel.text = "\(player.name) receives \(player.inventory[inventoryCount]) but faces a new \(enemy.type)!"
        inventoryCount += 1
        enemyPic.isHidden = false
        chest.isHidden = true
        inventory.isHidden = false
    }
    
    @IBAction func Attack(_ sender: Any) {
        generateAttackPwr()
        player.attackPwr = attackPwrTemp + attackPwrPlus
        generateAttackPwr()
        enemy.attackPwr = attackPwrTemp
        if enemy.attemptAttack(attackPwr: player.attackPwr) {
            player.attemptAttack(attackPwr: enemy.attackPwr)
            printLabel.text = "\(player.name) attacked \(enemy.type) for \(player.attackPwr)HP, but takes \(enemy.attackPwr) damage"
            updateHP()
            if enemy.isAlive == false {
                printLabel.text = "\(player.name) defeated \(enemy.type)!"
                enemyPic.isHidden = true
                chest.isHidden = false
                hideButtons()
                killCountPlus()
            }
            if player.isAlive == false {
                printLabel.text = "\(player.name) killed \(killCount) enemies before dying!"
                diedHide()
            }
        } else {
            player.attemptAttack(attackPwr: enemy.attackPwr)
            updateHP()
            printLabel.text = "\(player.name) failed to attack \(enemy.type) but takes \(enemy.attackPwr) damage"
            if player.isAlive == false {
                printLabel.text = "\(player.name) killed \(killCount) enemies before dying!"
                diedHide()
            }
            
        }
    }
    
    @IBAction func checkLoot(sender: AnyObject){
        var hpPlus = 0
        inventory.isHidden = true
        if player.inventory[0] != "" {
            for x in player.inventory {
                if x == "Rusty Dagger" {
                    attackPwrPlus += 2
                }
                if x == "Cracked Buckler" {
                    hpPlus += 10
                }
                if x == "Magic Wand"{
                    attackPwrPlus += 4
                }
                if x == "Dark Amulet" {
                    hpPlus += 20
                }
                if x == "Salted Pork" {
                    hpPlus += 10
                }
                if x == "Tough Hide" {
                    hpPlus += 15
                }
                if x == "Kymera Venom" {
                    attackPwrPlus += 7
                }
                if x == "Rare Trident" {
                    attackPwrPlus += 10
                }
            }
            player.hp += hpPlus
            printLabel.text = "You have gained \(attackPwrPlus) attack power and \(hpPlus) health by using all items!"
            updateHP()
            player.inventory.removeAll()
            inventoryCount = 0
            
        } else {
            printLabel.text = "You have no items!"
        }
        
    }
    
    @IBAction func restartGameButton(sender: AnyObject){
        restartGame()
    }
    
}

