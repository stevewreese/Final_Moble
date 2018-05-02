//
//  GameController.swift
//  Final_Projrect
//  This is the control and communitcation bewteen model and views
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit
//delegates for the control
protocol ControlDelegate: class
{
    //go to game view
    func goToGame()
    //go to high score view
    func goToHighScores()
    //go to main menu
    func goToMainMenu()
    //move ship up
    func moveUp()
    //move ship down
    func moveDown()
    //move ship right
    func moveRight()
    //move ship left
    func moveLeft()
    //stop the movement
    func stopMove()
    //start firing laser
    func startFire()
    //stop laser
    func stopFire()
    func pauseGame()
    func unPauseGame()
    //make new game
    func newGame()
}

class GameControl
{
    weak var delegate: ControlDelegate? = nil
    //the model of the game
    var theModel: GameModel? = nil
    //init with the ship and enemy coordinates
    init(coors: Array<Float>, eCoors: Array<Array<Float>>){
        theModel = GameModel(coors: coors, eCoors: eCoors)
    }
    //updated the ship and enemy coordinates
    func updateCoors(coors: Array<Float>, eCoors: Array<Array<Float>>){
        theModel?.updateCoors(coors: coors,  eCoors: eCoors)
    }
    //call go to game delegate
    func addGame()
    {
        delegate?.goToGame()
    }
    //resume the game
    func addNewGame(){
        delegate?.newGame()
    }
    //got ot high score
    func addHigh()
    {
        delegate?.goToHighScores()
    }
    //go to main menu
    func addMain()
    {
        delegate?.goToMainMenu()
    }
    //next 5 funtions control movement of the ship
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
    //start and stop fire
    func startFire(){
        delegate?.startFire()
    }
    
    func stopFire(){
        delegate?.stopFire()
    }
    //update bullet coordinates
    func updateBullet(bulletList: Array<UIView>){
        theModel?.bullets = bulletList
    }
    //update themodel every frame
    func update() -> results
    {
        return (theModel?.update())!
    }
    //controls the pausing of the game
    func pauseGame()
    {
         delegate?.pauseGame()
    }
    
    func unPauseGame()
    {
        delegate?.unPauseGame()
    }
    //checks if score is a high score and updates the list returns result
    func checkScore(score: Int) -> Bool{
        return (theModel?.checkScore(score: score))!
    }
    //transfers the list of high scorres
    func getHighScores() -> Array<highScore>
    {
        return (theModel?.getHighScores())!
    }
    
}
