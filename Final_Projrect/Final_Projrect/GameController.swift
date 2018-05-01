//
//  GameController.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

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
    func startFire()
    func stopFire()
    func pauseGame()
    func unPauseGame()
    func newGame()
}

class GameControl
{
    weak var delegate: ControlDelegate? = nil
    var theModel: GameModel? = nil
    
    init(coors: Array<Float>, eCoors: Array<Array<Float>>){
        theModel = GameModel(coors: coors, eCoors: eCoors)
    }
    
    func print(coors: Array<Float>){
        theModel?.printCoords(coors: coors)
    }
    
    func updateCoors(coors: Array<Float>, eCoors: Array<Array<Float>>){
        theModel?.updateCoors(coors: coors,  eCoors: eCoors)
    }
    
    func addGame()
    {
        delegate?.goToGame()
    }
    
    func addNewGame(){
        delegate?.newGame()
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
    
    func startFire(){
        delegate?.startFire()
    }
    
    func stopFire(){
        delegate?.stopFire()
    }
    
    func updateBullet(bulletList: Array<UIView>){
        theModel?.bullets = bulletList
    }
    
    func update() -> results
    {
        return (theModel?.update())!
    }
    
    func pauseGame()
    {
         delegate?.pauseGame()
    }
    
    func unPauseGame()
    {
        delegate?.unPauseGame()
    }
    
    func checkScore(score: Int) -> Bool{
        return (theModel?.checkScore(score: score))!
    }
    
    func getHighScores() -> Array<highScore>
    {
        return (theModel?.getHighScores())!
    }
    
}
