//
//  ViewHolder.swift
//  Final_Projrect
//  holder to hold all the views
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit
import Foundation

class ViewHolder: UIView, ControlDelegate
{
    
    var theGame: GameView = GameView(frame: UIScreen.main.bounds)
    var theHighScore: HighScore = HighScore(frame: UIScreen.main.bounds)
    var theMainMenu: MainMenu = MainMenu(frame: UIScreen.main.bounds)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        theMainMenu.backgroundColor = UIColor.white
        //self.addSubview(theGame)
        self.addSubview(theMainMenu)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
