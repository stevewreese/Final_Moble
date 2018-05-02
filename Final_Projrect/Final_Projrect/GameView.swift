//
//  GameView.swift
//  Final_Projrect
//  the view for the game
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class GameView: UIView{
    
    var theControl: GameControl? = nil
    
    let left = UIButton(frame: CGRect(x: 250, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let right = UIButton(frame: CGRect(x: 350, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let up = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 150), width: 50, height: 50))
    let down = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 50), width: 50, height: 50))
    let fire = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let main = UIButton(frame: CGRect(x: UIScreen.main.bounds.width
        - 100, y: 15, width: 100, height: 20))
    let pause = UIButton(frame: CGRect(x: 15, y: 15, width: 100, height: 20))
    
    var scoreLabel: UILabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 100, y: 20, width: 200, height: 21))
    
    var theBlue = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(1.0), alpha: CGFloat(0.5))
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = NSTextAlignment.center
        scoreLabel.textColor = .white
        self.addSubview(scoreLabel)
        
        
        left.backgroundColor = UIColor(white: 0, alpha: 0.2)
        left.setTitleColor(.white, for: .normal)
        left.setTitle("<", for: .normal)
        left.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        left.addTarget(self, action: #selector(GameView.moveLeft(sender:)), for: .touchDown)
        
        self.addSubview(left)
        
        right.backgroundColor = UIColor(white: 0, alpha: 0.2)
        right.setTitleColor(.white, for: .normal)
        right.setTitle(">", for: .normal)
        right.addTarget(self, action: #selector(GameView.moveRight(sender:)), for: .touchDown)
        right.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        
        self.addSubview(right)
        
        up.backgroundColor = UIColor(white: 0, alpha: 0.2)
        up.setTitleColor(.white, for: .normal)
        up.setTitle("up", for: .normal)
        up.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        up.addTarget(self, action: #selector(GameView.moveUp(sender:)), for: .touchDown)
        
        self.addSubview(up)
        
        down.backgroundColor = UIColor(white: 0, alpha: 0.2)
        down.setTitleColor(.white, for: .normal)
        down.setTitle("down", for: .normal)
        down.addTarget(self, action: #selector(GameView.moveDown(sender:)), for: .touchDown)
        down.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        
        self.addSubview(down)
        
        fire.backgroundColor = UIColor(white: 0, alpha: 0.2)
        fire.setTitleColor(.white, for: .normal)
        fire.setTitle("fire", for: .normal)
        fire.addTarget(self, action: #selector(GameView.fireBullet(sender:)), for: .touchDown)
        fire.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        
        self.addSubview(fire)
        
        
        main.backgroundColor = .gray
        main.setTitleColor(.white, for: .normal)
        main.setTitle("Main Menu", for: .normal)
        main.addTarget(self, action: #selector(GameView.toMain(sender:)), for: .touchUpInside)
        
        self.addSubview(main)
        
        pause.backgroundColor = .gray
        pause.setTitleColor(.white, for: .normal)
        pause.setTitle("pause", for: .normal)
        pause.addTarget(self, action: #selector(GameView.pause(sender:)), for: .touchUpInside)
        
        self.addSubview(pause)
        //gameLoop()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc func moveLeft(sender: UIButton!){
        sender.backgroundColor = theBlue

        theControl?.moveLeft()
        
        
    }
    
    @objc func moveRight(sender: UIButton!){
        sender.backgroundColor = theBlue

        theControl?.moveRight()

        
    }
    
    @objc func moveDown(sender: UIButton!){

        sender.backgroundColor = theBlue
        theControl?.moveDown()

    }
    
    @objc func moveUp(sender: UIButton!){
        sender.backgroundColor = theBlue
        theControl?.moveUp()
        
    }
    
    @objc func up(sender: UIButton!){
        sender.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        if(sender == fire)
        {
            theControl?.stopFire()
        }
        else{
            theControl?.stop()
        }
        

    }
    
    @objc func fireBullet(sender: UIButton!){
        sender.backgroundColor = theBlue
        theControl?.startFire()

        
    }
    
    @objc func toMain(sender: UIButton!) {
        theControl?.addMain()
        
    }
    
    @objc func pause(sender: UIButton!) {
        if(sender.titleLabel?.text == "pause")
        {
            theControl?.pauseGame()
            pause.setTitle("start", for: .normal)
        }
        else
        {
            theControl?.unPauseGame()
            pause.setTitle("pause", for: .normal)
            
        }

    }
    
    func setScore(score: Int){
        scoreLabel.text = "Score: \(score)"
    }
    
}
