//
//  GameModel.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class GameModel{
    
    var timer = Timer()
    
    var shipCoords: Array<Float>? = nil
    var enemyCoords: Array<Float>? = nil
    var enemyCoordsXY: Array<Float> = Array()
    var shipCoordsXY: Array<Float> = Array()
    var bullets: Array<UIView>? = nil
    
    func printCoords(coors: Array<Float>){
        for C in coors{
            print("\(C)")
        }
    }
    
    init(coors: Array<Float>, eCoors: Array<Float>){
        //timer = Timer.scheduledTimer(timeInterval: 0.01667, target: self,   selector: (#selector(GameModel.update)), userInfo: nil, repeats: true)
        shipCoords = coors
        enemyCoords = eCoors
        enemyCoors()
        
    }
    
    func updateCoors(coors: Array<Float>, eCoors: Array<Float>){
        shipCoords?.removeAll()
        enemyCoords?.removeAll()
        shipCoords = coors
        enemyCoords = eCoors
    }
    
    
    func update() -> Array<Int> {
        enemyCoors()
        shipCoors()
        checkShipColl()
        return checkBulletColl()
        

    }
    
    func enemyCoors(){
        enemyCoordsXY.removeAll()
        var x1: Float = 0.0
        var y1: Float = 0.0
        var x2: Float = 0.0
        var y2: Float = 0.0
        
        if(enemyCoords![0] < 0){
            x1 = Float( UIScreen.main.bounds.width / 2.0) * Float(1+enemyCoords![0])
        }
        else
        {
            x1 =  Float( UIScreen.main.bounds.width / 2) * Float(enemyCoords![0]) + Float(UIScreen.main.bounds.width/2)
        }
        if(enemyCoords![1] < 0)
        {
            x2 = Float( UIScreen.main.bounds.width / 2.0) * Float(1+enemyCoords![1])
        }
        else{
            x2 =  Float( UIScreen.main.bounds.width / 2.0) * Float(enemyCoords![1]) + Float(UIScreen.main.bounds.width/2)
        }

        if(enemyCoords![2] < 0){
            y1 = Float(UIScreen.main.bounds.height / 2.0) * Float(enemyCoords![2]) * -1 + Float(UIScreen.main.bounds.height/2)
        }
        else
        {
            y1 = Float( UIScreen.main.bounds.height / 2.0) * Float(1-enemyCoords![2])
        }
        if(enemyCoords![3] < 0){
            y2 = Float(UIScreen.main.bounds.height / 2.0) * Float(enemyCoords![3]) * -1 + Float(UIScreen.main.bounds.height/2)
        }
        else
        {
            y2 = Float( UIScreen.main.bounds.height / 2.0) * Float(1-enemyCoords![3])
        }

        
        enemyCoordsXY.append(x1)
        enemyCoordsXY.append(x2)
        enemyCoordsXY.append(y1)
        enemyCoordsXY.append(y2)
        
    }
    
    func shipCoors(){
        shipCoordsXY.removeAll()
        var x1: Float = 0.0
        var y1: Float = 0.0
        var x2: Float = 0.0
        var y2: Float = 0.0
        
        if(shipCoords![0] < 0){
            x1 = Float( UIScreen.main.bounds.width / 2.0) * Float(1+shipCoords![0])
        }
        else
        {
            x1 =  Float( UIScreen.main.bounds.width / 2) * Float(shipCoords![0]) + Float(UIScreen.main.bounds.width/2)
        }
        if(enemyCoords![1] < 0)
        {
            x2 = Float( UIScreen.main.bounds.width / 2.0) * Float(1+shipCoords![1])
        }
        else{
            x2 =  Float( UIScreen.main.bounds.width / 2.0) * Float(shipCoords![1]) + Float(UIScreen.main.bounds.width/2)
        }
        
        if(shipCoords![2] < 0){
            y1 = Float(UIScreen.main.bounds.height / 2.0) * Float(shipCoords![2]) * -1 + Float(UIScreen.main.bounds.height/2)
        }
        else
        {
            y1 = Float( UIScreen.main.bounds.height / 2.0) * Float(1-shipCoords![2])
        }
        if(shipCoords![3] < 0){
            y2 = Float(UIScreen.main.bounds.height / 2.0) * Float(shipCoords![3]) * -1 + Float(UIScreen.main.bounds.height/2)
        }
        else
        {
            y2 = Float( UIScreen.main.bounds.height / 2.0) * Float(1-shipCoords![3])
        }
        
        
        shipCoordsXY.append(x1)
        shipCoordsXY.append(x2)
        shipCoordsXY.append(y1)
        shipCoordsXY.append(y2)
        
    }
    
    func checkShipColl()
    {
        if(enemyCoordsXY[2] <= shipCoordsXY[2] && enemyCoordsXY[2] >= shipCoordsXY[3])
        {
            if(enemyCoordsXY[0] >= shipCoordsXY[0] && enemyCoordsXY[0] <= shipCoordsXY[1])
            {
                print("Hit Ship")
            }
        }
        else if(shipCoordsXY[3] <= enemyCoordsXY[2] && shipCoordsXY[3] >= enemyCoordsXY[3])
        {
            if(shipCoordsXY[0] >= enemyCoordsXY[0] && shipCoordsXY[0] <= enemyCoordsXY[1])
            {
                print("Hit Ship")
            }
        }
        else{
            print("Not Hit Ship")
        }
        
    }
    
    func checkBulletColl() -> Array<Int>
    {
        var index = 0
        var removeList: Array<Int> = Array()
        for b in bullets!{
            
            if(Int(b.frame.origin.y) >= Int(enemyCoordsXY[2]) && Int(b.frame.origin.y) <= Int(enemyCoordsXY[3])){
                if(Int(b.frame.origin.x) >= Int(enemyCoordsXY[0]) && Int(b.frame.origin.x) <= Int(enemyCoordsXY[1]))
                {
                    print("hit")
                    removeList.append(index)
                }

            }
            
            index+=1
            
        }
        
        return removeList
    }
    

    
}
