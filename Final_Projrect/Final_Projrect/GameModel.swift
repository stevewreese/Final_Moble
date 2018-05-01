//
//  GameModel.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

struct results {
    var removelist: Array<Int> = Array()
    var hit = false
}

class GameModel{
    
    var timer = Timer()
    
    var shipCoords: Array<Float>? = nil
    var enemyCoords: Array<Array<Float>>? = nil
    var enemyCoordsXY: Array<Array<Float>> = Array()
    var shipCoordsXY: Array<Float> = Array()
    var bullets: Array<UIView>? = nil
    
    func printCoords(coors: Array<Float>){
        for C in coors{
            print("\(C)")
        }
    }
    
    init(coors: Array<Float>, eCoors: Array<Array<Float>>){
        //timer = Timer.scheduledTimer(timeInterval: 0.01667, target: self,   selector: (#selector(GameModel.update)), userInfo: nil, repeats: true)
        shipCoords = coors
        enemyCoords = eCoors
        enemyCoors()
        
    }
    
    func updateCoors(coors: Array<Float>, eCoors: Array<Array<Float>>){
        shipCoords?.removeAll()
        enemyCoords?.removeAll()
        shipCoords = coors
        enemyCoords = eCoors
    }
    
    
    func update() -> results {
        enemyCoors()
        shipCoors()

        var theResults: results = results()
        
        theResults.hit = checkShipColl()
        theResults.removelist = checkBulletColl()
        return theResults
        

    }
    
    func enemyCoors(){
        enemyCoordsXY.removeAll()
        var x1: Float = 0.0
        var y1: Float = 0.0
        var x2: Float = 0.0
        var y2: Float = 0.0
        for eArray in enemyCoords!{
            if(eArray[0] < 0){
                x1 = Float( UIScreen.main.bounds.width / 2.0) * Float(1+eArray[0])
            }
            else
            {
                x1 =  Float( UIScreen.main.bounds.width / 2) * Float(eArray[0]) + Float(UIScreen.main.bounds.width/2)
            }
            if(eArray[1] < 0)
            {
                x2 = Float( UIScreen.main.bounds.width / 2.0) * Float(1+eArray[1])
            }
            else{
                x2 =  Float( UIScreen.main.bounds.width / 2.0) * Float(eArray[1]) + Float(UIScreen.main.bounds.width/2)
            }
            
            if(eArray[2] <= 0){
                y1 = Float(UIScreen.main.bounds.height / 2.0) * Float(eArray[2]) * -1 + Float(UIScreen.main.bounds.height/2)
            }
            else
            {
                y1 = Float( UIScreen.main.bounds.height / 2.0) * Float(1-eArray[2])
            }
            if(eArray[3] <= 0){
                y2 = Float(UIScreen.main.bounds.height / 2.0) * Float(eArray[3]) * -1 + Float(UIScreen.main.bounds.height/2)
            }
            else
            {
                y2 = Float( UIScreen.main.bounds.height / 2.0) * Float(1-eArray[3])
            }
            
            var newArray: Array<Float> = Array()
            
            newArray.append(x1)
            newArray.append(x2)
            newArray.append(y1)
            newArray.append(y2)
            
            enemyCoordsXY.append(newArray)
        }
        

        
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
        if(shipCoords![1] < 0)
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
    
    func checkShipColl() -> Bool
    {
        for eCoors in enemyCoordsXY
        {
            if((eCoors[2] <= shipCoordsXY[2] && eCoors[2] >= shipCoordsXY[3]) && (eCoors[0] >= shipCoordsXY[0] && eCoors[0] <= shipCoordsXY[1]))
            {
                
                return true
            }
            else if((shipCoordsXY[3] <= eCoors[2] && shipCoordsXY[3] >= eCoors[3]) && (shipCoordsXY[0] >= eCoors[0] && shipCoordsXY[0] <= eCoors[1]))
            {
                return true
            }
            else{
            }
        }
        return false

        
    }
    
    func checkBulletColl() -> Array<Int>
    {
        var indexB = 0

        var removeList: Array<Int> = Array()
        removeList.append(0)
        for b in bullets!{
            var indexS = 0
            for eCoors in enemyCoordsXY
            {
                if(Int(b.frame.origin.y) <= Int(eCoors[2]) && Int(b.frame.origin.y) >= Int(eCoors[3])){
                    if(Int(b.frame.origin.x) >= Int(eCoors[0]) && Int(b.frame.origin.x) <= Int(eCoors[1]))
                    {
                        print("hit")
                        removeList[0] = 1
                        removeList.append(indexB)
                        removeList.append(indexS)
                        return removeList
                    }
                    
                }
                indexS += 1
            }
            

            
            indexB += 1
            
        }
        
        return removeList
    }
    

    
}
