//
//  PLMoveLine.swift
//  SSPatternLock
//
//  Created by Savaş Salihoğlu on 23.09.2020.
//

import UIKit

class PLMoveLine: PLDrawItem {
    var path = UIBezierPath()
    var fillColor:UIColor
    var strokeColor:UIColor
    
    init(fillColor:UIColor,strokeColor:UIColor){
        self.fillColor = fillColor
        self.strokeColor = strokeColor
    }
    func draw() {
        strokeColor.setStroke()
        path.stroke()
    }
}
