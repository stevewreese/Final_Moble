//
//  GameView.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class GameView: UIView{
    
    var runGame = true;
    var ship = playerShip(frame: CGRect(x: Int(UIScreen.main.bounds.width/2), y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50) )
    let left = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let right = UIButton(frame: CGRect(x: 350, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    let up = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 150), width: 50, height: 50))
    let down = UIButton(frame: CGRect(x: 300, y: Int(UIScreen.main.bounds.height - 50), width: 50, height: 50))
    var board = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 736))
    var timer = Timer()
    var movementSpeed = 5
    enum mainShipMove {case stop, left, right, up, down}
    var theBlue = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(1.0), alpha: CGFloat(0.5))
    var shipMove: mainShipMove = mainShipMove.stop
    //var displayLink = CADisplayLink(target: self, selector: #selector(update))
    
    var initX = 0
    var finalX = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        ship.backgroundColor = UIColor.white
        self.addSubview(ship)
        self.addSubview(board)
        
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
        timer = Timer.scheduledTimer(timeInterval: 0.01667, target: self,   selector: (#selector(GameView.update)), userInfo: nil, repeats: true)        //gameLoop()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func gameLoop(){
        //displayLink.preferredFramesPerSecond = 1
        //displayLink.add(to: .main, forMode: .commonModes)
        /*while(runGame){
            
        }*/
    }
    
    @objc func update() {
        
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
        
        
    }
    
    @objc func moveRight(sender: UIButton!){
        sender.backgroundColor = theBlue

        shipMove = mainShipMove.right

        
    }
    
    @objc func moveDown(sender: UIButton!){
        

        shipMove = mainShipMove.down
        sender.backgroundColor = theBlue
        
        
    }
    
    @objc func moveUp(sender: UIButton!){
        sender.backgroundColor = theBlue

        shipMove = mainShipMove.up
        
        
    }
    
    @objc func up(sender: UIButton!){
        sender.backgroundColor = UIColor(white: 1, alpha: 0)
        shipMove = mainShipMove.stop

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
