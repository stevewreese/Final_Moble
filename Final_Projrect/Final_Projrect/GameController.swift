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
}

class GameControl
{
    weak var delegate: ControlDelegate? = nil
    
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
    
}
