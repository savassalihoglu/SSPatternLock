//
//  PLManager.swift
//  SSPatternLock
//
//  Created by Savaş Salihoğlu on 23.09.2020.
//

import UIKit

protocol TouchDelegate {
    func touchesBegan(_ point:CGPoint)
    func touchesMoved(_ point:CGPoint)
    func touchesEnded(_ point:CGPoint)
}

class PatternManager : TouchDelegate {
    
    var touchEndPoint = CGPoint()
    var touchMove = false
    var touchEnd = false
    var nodes = [PLNode]()
    var selectedNodes = [PLNode]()
    var selectedIndexes:(([Int])->())?
    weak var patternLockView:SSPatternLockView!
    var moveLine:PLMoveLine
    var drawItems = [PLDrawItem]()
    var initForIB = false
    var config:SSPatternLockView.Config
    
    init(patternLockView:SSPatternLockView,config:SSPatternLockView.Config){
        self.config = config
        self.patternLockView = patternLockView
        self.moveLine = PLMoveLine(fillColor: config.lineColor, strokeColor: config.lineColor)
    }
    func draw(_ rect: CGRect){
        if !initForIB {
            initForIB = true
            calcNodeSizes(rect)
        }
        drawItems.forEach({$0.draw()})
    }
    func update(){
        if touchMove || touchEnd {
            moveLine.path.removeAllPoints()
            moveLine.path.lineWidth = config.lineWidth
            
            moveLine.path.miterLimit = 0.1
            for (i,node) in selectedNodes.enumerated(){
                if i == 0 {
                    moveLine.path.move(to: node.center)
                }else{
                    moveLine.path.addLine(to: node.center)
                }
            }
            if touchMove &&  selectedNodes.count > 0 {
                moveLine.path.addLine(to: touchEndPoint)
            }
        }
        drawItems.removeAll()
        drawItems.append(moveLine)
        drawItems.append(contentsOf: selectedNodes.map({ $0.highlightCircle }))
        drawItems.append(contentsOf: nodes)
        patternLockView.setNeedsDisplay()
    }
    
    func touchesBegan(_ point:CGPoint) {
        selectedNodes.removeAll()
        update()
    }
    
    func touchesMoved(_ point:CGPoint) {
        touchEndPoint = point
        touchMove = true
        var isNeighborNode = true
        
        for node in nodes{
            if let lastSelectedNode = selectedNodes.last {
                if lastSelectedNode.index == node.index {
                    continue
                }
                isNeighborNode=lastSelectedNode.neighborNodes.contains(where: {$0.index == node.index})
            }
            if isNeighborNode,node.rect.contains(touchEndPoint)  {
                selectedNodes.append(node)
            }
        }
        update()
    }
    
    func touchesEnded(_ point:CGPoint) {
        touchMove=false
        touchEnd=true
        if let selectedIndexes = self.selectedIndexes {
            selectedIndexes(selectedNodes.map({$0.index}))
        }
        selectedNodes.removeAll()
        update()
    }
    func calcNodeSizes(_ rect:CGRect){
    
        let columnCount = config.columnCount
        let rowCount = config.rowCount
        let spaceBetweenNodes = CGFloat(config.spaceBetweenNodes)
        nodes.removeAll()
        
        let nodeWidth = min((rect.width-(CGFloat(columnCount+1)*spaceBetweenNodes)  ) / CGFloat(columnCount) , (rect.height-(CGFloat(rowCount+1)*spaceBetweenNodes)  ) / CGFloat(rowCount))
        
        let xOffset = (rect.width - (nodeWidth*CGFloat(columnCount)) - (CGFloat(columnCount-1)*spaceBetweenNodes)) / 2.0
        let yOffset = (rect.height - (nodeWidth*CGFloat(rowCount)) - (CGFloat(rowCount-1)*spaceBetweenNodes)) / 2.0
        
        let xSubOffset = xOffset + nodeWidth/4.0
        let ySubOffset = yOffset + nodeWidth/4.0
        
        for i in 0...rowCount-1{
            for j in 0...columnCount-1{
                
                let circlePath = UIBezierPath(ovalIn: CGRect(x: CGFloat(j)*nodeWidth + xOffset + (CGFloat(j)*spaceBetweenNodes) , y: CGFloat(i)*nodeWidth + yOffset + (CGFloat(i)*spaceBetweenNodes), width: nodeWidth, height: nodeWidth))
                circlePath.lineWidth = 3.0
                let subCirclePath = UIBezierPath(ovalIn: CGRect(x: CGFloat(j)*nodeWidth + xSubOffset + (CGFloat(j)*spaceBetweenNodes) , y: CGFloat(i)*nodeWidth + ySubOffset + (CGFloat(i)*spaceBetweenNodes), width: nodeWidth/2.0, height: nodeWidth/2.0))
      
                let node = PLNode(fillColor: config.nodeFillColor, strokeColor: config.nodeStrokeColor, center: CGPoint(x: circlePath.bounds.midX, y: circlePath.bounds.midY), rect: subCirclePath.bounds,path: subCirclePath,highlightCircle: PLHighlightCircle(fillColor: config.nodeHighLightFillColor, strokeColor: config.nodeHighLightStrokeColor,path:circlePath))
                //node.rect=subCirclePath.bounds
                
                node.index = Int(i*rowCount + j)
                //node.center = CGPoint(x: circlePath.bounds.midX, y: circlePath.bounds.midY)
                //node.path = subCirclePath
                //node.highlightCircle.path = circlePath
                //node.fillColor = config.nodeFillColor
                //node.strokeColor = config.nodeStrokeColor
                //node.highlightCircle.fillColor = config.nodeHighLightFillColor
                //node.highlightCircle.strokeColor = config.nodeHighLightStrokeColor
                
                nodes.append(node)
            }
        }
        
        for (i,node) in nodes.enumerated() {
            if i-1 >= 0 && i%columnCount != 0 {
                node.neighborNodes.append(nodes[i-1])
            }
            if i+1 < nodes.count && (i+1)%columnCount != 0  {
                node.neighborNodes.append(nodes[i+1])
            }
            for j in i-columnCount-1...i-columnCount+1 {
                if (i%columnCount==0 && j == (i-columnCount-1)) || ((i+1)%columnCount==0 && j == (i-columnCount+1))  {
                    continue
                }
                if j >= 0 {
                    node.neighborNodes.append(nodes[j])
                }
            }
            
            for j in i+columnCount-1...i+columnCount+1 {
                if (i%columnCount==0 && j == (i+columnCount-1)) || ((i+1)%columnCount==0 && j == (i+columnCount+1)) {
                    continue
                }
                if j < nodes.count {
                    node.neighborNodes.append(nodes[j])
                }
            }
        }
        update()
    }
   
    
}

