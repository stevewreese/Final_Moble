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
    let left = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let right = UIButton(frame: CGRect(x: 350, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let up = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 150), width: 50, height: 50))
    let down = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 50), width: 50, height: 50))
    let fire = UIButton(frame: CGRect(x: 0, y: Int(UIScreen.main.bounds.height - 50), width: 50, height: 50))
    let main = UIButton(frame: CGRect(x: UIScreen.main.bounds.width
        - 100, y: 15, width: 100, height: 20))
    let pause = UIButton(frame: CGRect(x: 15, y: 15, width: 100, height: 20))
    
   
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
        
        left.backgroundColor = UIColor(white: 1, alpha: 0)
        left.setTitleColor(.black, for: .normal)
        left.setTitle("<", for: .normal)
        left.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        left.addTarget(self, action: #selector(GameView.moveLeft(sender:)), for: .touchDown)
        
        self.addSubview(left)
        
        right.backgroundColor = UIColor(white: 1, alpha: 0)
        right.setTitleColor(.black, for: .normal)
        right.setTitle(">", for: .normal)
        right.addTarget(self, action: #selector(GameView.moveRight(sender:)), for: .touchDown)
        right.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        
        self.addSubview(right)
        
        up.backgroundColor = UIColor(white: 1, alpha: 0)
        up.setTitleColor(.black, for: .normal)
        up.setTitle("up", for: .normal)
        up.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        up.addTarget(self, action: #selector(GameView.moveUp(sender:)), for: .touchDown)
        
        self.addSubview(up)
        
        down.backgroundColor = UIColor(white: 1, alpha: 0)
        down.setTitleColor(.black, for: .normal)
        down.setTitle("down", for: .normal)
        down.addTarget(self, action: #selector(GameView.moveDown(sender:)), for: .touchDown)
        down.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        
        self.addSubview(down)
        
        fire.backgroundColor = UIColor(white: 1, alpha: 0)
        fire.setTitleColor(.black, for: .normal)
        fire.setTitle("fire", for: .normal)
        fire.addTarget(self, action: #selector(GameView.fireBullet(sender:)), for: .touchDown)
        fire.addTarget(self, action: #selector(GameView.up(sender:)), for: .touchUpInside)
        
        self.addSubview(fire)
        
        
        main.backgroundColor = .gray
        main.setTitleColor(.black, for: .normal)
        main.setTitle("Main Menu", for: .normal)
        main.addTarget(self, action: #selector(GameView.toMain(sender:)), for: .touchUpInside)
        
        self.addSubview(main)
        
        pause.backgroundColor = .gray
        pause.setTitleColor(.black, for: .normal)
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
    
    @objc func update() {
        
        if(shipsSecondCount == 60)
        {
            makeNewShip(theX: xplus, theY: -100)
            xplus = xplus + 50
            if(xplus == 400)
            {
                xplus = 0
            }
            shipsSecondCount = 0
        }
        else{
            shipsSecondCount = 1 + shipsSecondCount
        }
        var shipIndex = 0
        for ship in enemyList
        {
            ship.frame.origin.y = ship.frame.origin.y + 5
            
            if(ship.frame.origin.y + 10 == UIScreen.main.bounds.height)
            {
                enemyList.remove(at: shipIndex)
                ship.removeFromSuperview()
            }
            
            shipIndex = shipIndex + 1

        }
        
        
        if(fireTheBullet)
        {
            if(whenToFire == 10)
            {
                var bullet: UIView = UIView(frame: CGRect(x: self.ship.frame.origin.x + 25, y: self.ship.frame.origin.y, width: 2, height: 10))
                bullet.backgroundColor = UIColor.red
                bulletList.append(bullet)
                self.addSubview(bullet)
                whenToFire = 0
            }
            else
            {
                whenToFire = whenToFire + 1
            }

        }
        else{
            whenToFire = 10
        }

        
        var index = 0
        
        for bullet in bulletList
        {
            bullet.frame.origin.y = bullet.frame.origin.y - 10
            if(bullet.frame.origin.y - 10 == 0)
            {
                bulletList.remove(at: index)
                bullet.removeFromSuperview()
            }
            index = index + 1
        }
        
        switch(shipMove)
        {
        case .left :
            if(self.ship.frame.origin.x <= 0)
            {
                
            }
            else{
                self.ship.frame.origin.x =  ship.frame.origin.x - CGFloat(movementSpeed)
            }
            break
        case .stop:
            break
        case .right:
            if(self.ship.frame.origin.x >= UIScreen.main.bounds.width - 50)
            {
                
            }
            else{
                self.ship.frame.origin.x =  ship.frame.origin.x  + CGFloat(movementSpeed)
            }
            break
        case .up:
            if(self.ship.frame.origin.y <= 0)
            {
                
            }
            else{
                self.ship.frame.origin.y =  ship.frame.origin.y - CGFloat(movementSpeed)
            }
            break
        case .down:
            if(self.ship.frame.origin.y >= UIScreen.main.bounds.height - 50)
            {
                
            }
            else{
                self.ship.frame.origin.y =  ship.frame.origin.y + CGFloat(movementSpeed)
            }
            break
        }
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
        sender.backgroundColor = UIColor(white: 1, alpha: 0)
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
        if(running)
        {
            stopGame()
            pause.setTitle("start", for: .normal)
        }
        else
        {
            //startGame()
            
        }
        
        
    }
    
    func makeNewShip(theX: Int, theY: Int)
    {
        var eShip = playerShip(frame: CGRect(x: theX, y: theY, width: 50, height: 50) )
        eShip.backgroundColor = UIColor.white
        eShip.backgroundColor = UIColor.blue
        self.addSubview(eShip)
        enemyList.append(eShip)
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
