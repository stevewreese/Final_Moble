//
//  GameView.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class GameView: UIView{
    
    var theControl: GameControl? = nil
    
    var runGame = true;
    var ship = playerShip(frame: CGRect(x: Int(UIScreen.main.bounds.width/2), y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50) )
    let left = UIButton(frame: CGRect(x: 250, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let right = UIButton(frame: CGRect(x: 350, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let up = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 150), width: 50, height: 50))
    let down = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 50), width: 50, height: 50))
    let fire = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let main = UIButton(frame: CGRect(x: UIScreen.main.bounds.width
        - 100, y: 15, width: 100, height: 20))
    let pause = UIButton(frame: CGRect(x: 15, y: 15, width: 100, height: 20))
    
    var scoreLabel: UILabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 100, y: 20, width: 200, height: 21))
    
   
    var bulletList: Array<UIView> = Array()
    var enemyList: Array<UIView> = Array()
    var fireTheBullet = false
    var whenToFire = 10

    //var timer = Timer()
    var movementSpeed = 5
    enum mainShipMove {case stop, left, right, up, down}
    var theBlue = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(1.0), alpha: CGFloat(0.5))
    var shipMove: mainShipMove = mainShipMove.stop
    //var displayLink = CADisplayLink(target: self, selector: #selector(update))
    
    var initX = 0
    var finalX = 0
    
    var i = 0
    var shipsSecondCount = 0
    
    var running = false
    
    var xplus = 0
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //ship.backgroundColor = UIColor.white
        //self.addSubview(ship)
        
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
    
    func startGame()
    {
        //timer = Timer.scheduledTimer(timeInterval: 0.01667, target: self,   selector: (#selector(GameView.update)), userInfo: nil, repeats: true)
        running = true
        pause.setTitle("pause", for: .normal)
    }
    
    func stopGame()
    {
        //timer.invalidate()
        running = false
    }
    
    func gameLoop(){
        //displayLink.preferredFramesPerSecond = 1
        //displayLink.add(to: .main, forMode: .commonModes)
        /*while(runGame){
            
        }*/
    }
    
    @objc func moveLeft(sender: UIButton!){
        sender.backgroundColor = theBlue
        
        shipMove = mainShipMove.left
        theControl?.moveLeft()
        
        
    }
    
    @objc func moveRight(sender: UIButton!){
        sender.backgroundColor = theBlue

        shipMove = mainShipMove.right
        theControl?.moveRight()

        
    }
    
    @objc func moveDown(sender: UIButton!){
        

        shipMove = mainShipMove.down
        sender.backgroundColor = theBlue
        theControl?.moveDown()
        
        
    }
    
    @objc func moveUp(sender: UIButton!){
        sender.backgroundColor = theBlue

        shipMove = mainShipMove.up
        theControl?.moveUp()
        
    }
    
    @objc func up(sender: UIButton!){
        sender.backgroundColor = UIColor(white: 0, alpha: 0.2)
        theControl?.stop()
        if(sender == fire)
        {
            theControl?.stopFire()
        }
        else{
            shipMove = mainShipMove.stop
        }
        

    }
    
    @objc func fireBullet(sender: UIButton!){
        sender.backgroundColor = theBlue
        fireTheBullet = true
        theControl?.startFire()

        
    }
    
    @objc func toMain(sender: UIButton!) {
        theControl?.addMain()
        stopGame()
        
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
    
    
 
    
   /* func drawTriangle(x: Int, y: Int)
    {
        let trianglezone = CGRect(x: x, y: y, width: 50, height: 50)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        print("minX \(trianglezone.minX), maxY \(trianglezone.maxY)")
        context.move(to: CGPoint(x: trianglezone.minX, y: trianglezone.maxY))
        context.addLine(to: CGPoint(x: trianglezone.maxX, y: trianglezone.maxY))
        context.addLine(to: CGPoint(x: (trianglezone.maxX / 2.0), y: trianglezone.minY))
        context.closePath()
        
        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
        context.fillPath()
    } */
    
}
