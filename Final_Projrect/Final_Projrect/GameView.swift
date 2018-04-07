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
    //let left = UIButton(frame: CGRect(x: 0, y: Int(UIScreen.main.bounds.height - 100), width: 50, height: 50))
    var board = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 736))
    var initX = 0
    var finalX = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        ship.backgroundColor = UIColor.white
        self.addSubview(ship)
        self.addSubview(board)
        
        /*left.backgroundColor = UIColor(white: 1, alpha: 0)
        left.setTitleColor(.black, for: .normal)
        left.setTitle("<", for: .normal)
        left.addTarget(self, action: #selector(GameView.moveLeft(sender:)), for: .touchUpInside)
        
        self.addSubview(left)*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func gameLoop(){
        while(runGame){
            
        }
    }
    
    @objc func moveLeft(sender: UIButton!){
        self.ship.frame.origin.x =  ship.frame.origin.x - 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point: CGPoint = (touches.first?.location(in: board))!
        initX = Int(point.x)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        //get the point of the finger
        
        let point: CGPoint = (touches.first?.location(in: board))!
        finalX = Int(point.x)
        
        var moveThisMany:CGFloat = 0

        moveThisMany = CGFloat(finalX - initX)

        
        /*if(self.ship.frame.origin.x + moveThisMany  <= 10)
        {
            self.ship.frame.origin.x = 10
        }
        else if(self.ship.frame.origin.x + moveThisMany >= 360)
        {
            self.ship.frame.origin.x = 360
        }
        else{
            self.ship.frame.origin.x =  CGFloat(finalX)
        }*/
        self.ship.frame.origin.x =  CGFloat(finalX)
        
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
