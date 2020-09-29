//
//  PLHighlightCircle.swift
//  SSPatternLock
//
//  Created by Savaş Salihoğlu on 23.09.2020.
//

import UIKit

class PLHighlightCircle : PLDrawItem {
    var path:UIBezierPath
    var fillColor:UIColor
    var strokeColor:UIColor
    init(fillColor:UIColor,strokeColor:UIColor,path:UIBezierPath){
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.path = path
    }
    func draw() {
        fillColor.setFill()
        strokeColor.setStroke()
        path.fill()
        path.stroke()
    }
}

