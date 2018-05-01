//
//  MainMenu.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class MainMenu:  UIView{
    
    var theControl: GameControl? = nil
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    let NewGame = UIButton(frame: CGRect(x: Int(UIScreen.main.bounds.width/2 - 100), y: 250, width: 150, height: 50))
    let Resume = UIButton(frame: CGRect(x: Int(UIScreen.main.bounds.width/2 - 100), y: 325, width: 150, height: 50))
    let HighScore = UIButton(frame: CGRect(x: Int(UIScreen.main.bounds.width/2 - 100), y: 400, width: 150, height: 50))
    
    var resume = false
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let title = UILabel(frame: CGRect(x: 60, y: 50, width: 500, height: 200))
        title.text = "Space Wars"
        title.font = title.font.withSize(50)
        title.textColor = .white
        //title.textAlignment = NSTextAlignment.center
        self.addSubview(title)
        
        NewGame.setTitle("New Game", for: .normal)
        NewGame.backgroundColor = .white
        NewGame.setTitleColor(.black, for: .normal)
        NewGame.addTarget(self, action: #selector(MainMenu.GoToNewGame(sender:)), for: .touchUpInside)
        self.addSubview(NewGame)
        
        Resume.setTitle("Resume Game", for: .normal)
        Resume.backgroundColor = .gray
        Resume.setTitleColor(.black, for: .normal)
        Resume.addTarget(self, action: #selector(MainMenu.GoToGame(sender:)), for: .touchUpInside)
        //NewGame.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        self.addSubview(Resume)
        
        HighScore.setTitle("High Scores", for: .normal)
        HighScore.backgroundColor = .white
        HighScore.setTitleColor(.black, for: .normal)
        HighScore.addTarget(self, action: #selector(MainMenu.GoToHighScore(sender:)), for: .touchUpInside)
        self.addSubview(HighScore)
        

    }
    
    @objc func GoToGame(sender: UIButton!) {
        if(resume)
        {
            theControl?.addGame()
        }


    }
    
    @objc func GoToNewGame(sender: UIButton!) {
        theControl?.addNewGame()
        whiteOut()
        
    }
    
    @objc func GoToHighScore(sender: UIButton!) {
        theControl?.addHigh()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func greyOut(){
        Resume.backgroundColor = .gray
        resume = false
    }
    
    func whiteOut(){
        Resume.backgroundColor = .white
        resume = true
    }
    
}
