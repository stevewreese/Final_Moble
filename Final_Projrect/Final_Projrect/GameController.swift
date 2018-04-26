//
//  GameController.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import Foundation

protocol ControlDelegate: class
{
    func goToGame()
    func goToHighScores()
    func goToMainMenu()
    func moveUp()
    func moveDown()
    func moveRight()
    func moveLeft()
    func stopMove()
}

class GameControl
{
    weak var delegate: ControlDelegate? = nil
    var theModel: GameModel? = nil
    
    init(coors: Array<Float>){
        theModel = GameModel(coors: coors)
    }
    
    func print(coors: Array<Float>){
        theModel?.printCoords(coors: coors)
    }
    
    func updateCoors(coors: Array<Float>){
        theModel?.updateCoors(coors: coors)
    }
    
    func addGame()
    {
        delegate?.goToGame()
    }
    
    func addHigh()
    {
        delegate?.goToHighScores()
    }
    
    func addMain()
    {
        delegate?.goToMainMenu()
    }
    
    func moveUp(){
        delegate?.moveUp()
    }
    
    func moveDown(){
        delegate?.moveDown()
    }
    
    func moveRight(){
        delegate?.moveRight()
    }
    
    func moveLeft(){
        delegate?.moveLeft()
    }
    
    func stop(){
        delegate?.stopMove()
    }
}
