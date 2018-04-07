//
//  ViewHolder.swift
//  Final_Projrect
//  holder to hold all the views
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit
import Foundation

class ViewHolder: UIView
{
    
    var theGame: GameView = GameView(frame: UIScreen.main.bounds)
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        theGame.backgroundColor = UIColor.white
        self.addSubview(theGame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
