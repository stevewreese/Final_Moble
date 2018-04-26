//
//  GameModel.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import Foundation

class GameModel{
    
    var timer = Timer()
    
    var shipCoords: Array<Float>? = nil
    
    func printCoords(coors: Array<Float>){
        for C in coors{
            print("\(C)")
        }
    }
    
    init(coors: Array<Float>){
           timer = Timer.scheduledTimer(timeInterval: 0.01667, target: self,   selector: (#selector(GameModel.update)), userInfo: nil, repeats: true)
        shipCoords = coors
        
    }
    
    func updateCoors(coors: Array<Float>){
        shipCoords = coors
    }
    
    
    @objc func update() {
        
        //print("running")
        
        if((shipCoords![1] >= 0.0 && shipCoords![5] <= 0.0) && ()){
            print("Hit middle")
        }
        else{
            print("Not Hit middle")
        }
    }
    

    
}
