//
//  SimoneBrain.swift
//  Simone
//
//  Created by Local Admin on 2017-07-03.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation
import UIKit

//=============================================
class SimonBrain{
    
    //---------------------------------

    var gameColors: [UIButton]
    var colorIndex: Int!
    var arrRandomColors: [UIButton] = []
    var userTurnToPlay: Bool!
    var scoreTracker = ""
    var colorToHighlight: UIButton!
    var arrCopyOfRandomColorToCompare: [UIButton]!
    var scoreKeeperCounter: Int!
    var timerLabel: UILabel!
    var aTimer: Timer!
    
    //-------------------------------
    
    init(gameColors: [UIButton], timerLabel: UILabel) {
        self.gameColors = gameColors
        self.timerLabel = timerLabel
    }
    
    
    
    //----------------------------------------
    func getRandomNumber(from f: Int, to t: Int) -> Int{
        
        let from =  UInt32(f)
        let to = UInt32(t)
        let randomNumber = arc4random_uniform(to - from + 1) + from
        return Int(randomNumber)
    }
    //----------------------------------
    func startGame()
    {
        colorIndex = 0
        
        //--------------------------
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){_ in
            self.gameColorsToHighlightManager()
        }
        
    }
    
    //------------------------------------
    func gameColorsToHighlightManager()
    {
        
        if colorIndex < arrRandomColors.count
        {
            userTurnToPlay = false
            scoreKeeper = ""
            colorToHighlight = arrRandomColors[colorIndex]
            colorToHighlight.alpha = 0.2
            colorIndex! += 1
            scoreKeeperCounter = 0
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
                self.ResetAlphaForColors()
            }
            
        }
        else
        {
            userTurnToPlay = true
            
            var sec = 30
            aTimer = Timer.scheduledTimer(withTimeInterval: 1.0 , repeats: true){_ in
                self.timerLabel.text = "YOUR TURN : \(sec) s"
                if sec == 0
                {
                    self.aTimer.invalidate()
                    SingletonShared.SingletonSharedInstance.saveScore(String(self.arrRandomColors.count - 1))
                }
                sec -= 1
            }
            
        }
        
    }
    
    //------------------------------------
    
   func ResetAlphaForColors()
   {
    //--------------------
    colorToHighlight.alpha = 1.0
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
        self.gameColorsToHighlightManager()

    
   }
    
    
}
  
    //----------------------------------
    var scoreKeeper: String?
        {
        get{
            return scoreTracker
            
        }
        set{
            
            scoreTracker = newValue!
        }
       }
    //----------------------------------
    func verification(_ aButton: UIButton)-> Bool{
        
        if arrCopyOfRandomColorToCompare[0] == aButton{
            arrCopyOfRandomColorToCompare.removeFirst()
            if arrCopyOfRandomColorToCompare.count == 0
            {
                colorIndex = 0
                addRandomColorsToArray()
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false){_ in
                    self.gameColorsToHighlightManager()
            }
        }
            return true
        }else {
            return false
        }
 
}

    //----------------------------------
    func addRandomColorsToArray()
    {
        let randomImdex = getRandomNumber(from: 0, to: gameColors.count - 1)
        arrRandomColors.append(gameColors[randomImdex])
        
        
    }
    
    //----------------------------------
    
    func loadArrayForComparaison(){
        arrCopyOfRandomColorToCompare = arrRandomColors
    }

    

}

//======================================
























