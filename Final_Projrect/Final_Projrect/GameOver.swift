//
//  GameOver.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 5/1/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class GameOver: UIView{
    
    var theControl: GameControl? = nil
    var highScore = false
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
            var scoreLabel: UILabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 100, y: UIScreen.main.bounds.height/2 - 100, width: 200, height: 21))
        scoreLabel.text = "Game Over"
        scoreLabel.textAlignment = NSTextAlignment.center
        scoreLabel.textColor = .white
        
        self.addSubview(scoreLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
        if(highScore){
            theControl?.addHigh()
        }else{
            theControl?.addMain()
        }
        
    }
}
