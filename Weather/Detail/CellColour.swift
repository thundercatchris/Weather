//
//  CellColour.swift
//  Weather
//
//  Created by Cerebro on 21/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import UIKit

class CellColour {
    
    func colorForIndex(section: Int, index: Int, sectionTotal: Int) -> UIColor {
        let itemCount = 8
        let firstColour = (red: CGFloat(126), green:CGFloat(188), blue: CGFloat(255))
        let SecondColour = (red: CGFloat(20), green:CGFloat(20), blue: CGFloat(200))
        var adjustedIndexForGradient = index
        
        if sectionTotal < itemCount {
            adjustedIndexForGradient = index + (itemCount - sectionTotal)
        }
        
        let red = colourVariation(firstColour: firstColour.red, secondColour: SecondColour.red, adjustedIndex: adjustedIndexForGradient, numberOfCells: itemCount)
        let green = colourVariation(firstColour: firstColour.green, secondColour: SecondColour.green, adjustedIndex: adjustedIndexForGradient, numberOfCells: itemCount)
        let blue = colourVariation(firstColour: firstColour.blue, secondColour: SecondColour.blue, adjustedIndex: adjustedIndexForGradient, numberOfCells: itemCount)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func colourVariation(firstColour:CGFloat, secondColour:CGFloat, adjustedIndex:Int, numberOfCells: Int) -> CGFloat {
        let multiplier = (firstColour - secondColour) / CGFloat(numberOfCells)
        return ((firstColour - (multiplier * CGFloat(adjustedIndex))) / 255.0)
    }
    
    
    
    
}
