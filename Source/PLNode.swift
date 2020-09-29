//
//  PLNode.swift
//  SSPatternLock
//
//  Created by Savaş Salihoğlu on 23.09.2020.
//

import UIKit

class PLNode : PLDrawItem {
    
    var path:UIBezierPath
    var fillColor:UIColor
    var strokeColor:UIColor
    var rect:CGRect
    var center:CGPoint
    var highlightCircle:PLHighlightCircle
    var neighborNodes = [PLNode]()
    var index = 0
    
    init(fillColor:UIColor,strokeColor:UIColor,center:CGPoint,rect:CGRect,path:UIBezierPath,highlightCircle:PLHighlightCircle){
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.center = center
        self.rect = rect
        self.path = path
        self.highlightCircle = highlightCircle
    }
    func draw() {
        fillColor.setFill()
        strokeColor.setStroke()
        path.fill()
        path.stroke()
    }
}
