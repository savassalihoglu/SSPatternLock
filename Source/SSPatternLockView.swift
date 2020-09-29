//
//  PatternLockView.swift
//  SSPatternLock
//
//  Created by Savaş Salihoğlu on 23.09.2020.
//

import UIKit

@objc public protocol SSPatternLockDelegate {
    func patternLockSelected(_ patternLockView:SSPatternLockView,_ selectedIndexes:[Int])
}

@IBDesignable public class SSPatternLockView: UIView {
    
    @IBInspectable public var rowCount:UInt = 0 {
        didSet {
            config.rowCount = Int(rowCount)
        }
    }
    @IBInspectable public var columnCount:UInt = 0{
        didSet{
            config.columnCount = Int(columnCount)
        }
    }
    
    @IBInspectable public var fillColor: UIColor? {
        didSet {
            config.nodeFillColor = fillColor!
        }
    }
    @IBInspectable public var strokeColor: UIColor? {
        didSet {
            config.nodeStrokeColor = strokeColor!
        }
    }
    
    @IBInspectable public var highlightFillColor: UIColor? {
        didSet {
            config.nodeHighLightFillColor = highlightFillColor!
        }
    }
    @IBInspectable public var highlisghtStrokeColor: UIColor? {
        didSet {
            config.nodeHighLightStrokeColor = highlisghtStrokeColor!
        }
    }
    
    @IBInspectable public var lineColor:UIColor? {
        didSet{
            config.lineColor = lineColor!
        }
    }
    @IBInspectable public var lineWidth:UInt = 0{
        didSet{
            config.lineWidth = CGFloat(lineWidth)
        }
    }
    
    @IBInspectable public var spaceBetweenNodes:UInt = 0{
        didSet{
            config.spaceBetweenNodes = CGFloat(spaceBetweenNodes)
        }
    }

    
    lazy var patternManager:PatternManager = { [weak self] in
        let  p = PatternManager(patternLockView: self!,config: config)
        p.selectedIndexes = { selectedIndexes in
            if let delegate = self!.delegate {
                delegate.patternLockSelected(self!, selectedIndexes)
            }
        }
        return p
    }()
    
    public var config = Config(){
        didSet{
            patternManager.config = config
            setup()
        }
    }
    @IBOutlet var delegate:SSPatternLockDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup(){
        backgroundColor = config.backgroundColor
    }
    
    public override func draw(_ rect: CGRect) {
        patternManager.draw(rect)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        patternManager.touchesBegan(touches.first!.location(in: self))
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        patternManager.touchesMoved(touches.first!.location(in: self))
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        patternManager.touchesEnded(touches.first!.location(in: self))
    }
    
    public struct Config {
        var nodeFillColor:UIColor = .black
        var nodeStrokeColor:UIColor = .clear
        var nodeHighLightFillColor:UIColor = .clear
        var nodeHighLightStrokeColor:UIColor = .black
        var lineColor:UIColor = .black
        var lineWidth:CGFloat = 5.0
        var backgroundColor:UIColor = .clear
        var columnCount:Int = 4
        var rowCount:Int = 4
        var spaceBetweenNodes:CGFloat = 20
        
        init(){
            
        }
        
        public init(builder:Builder) {
            nodeFillColor = builder.nodeFillColor ?? nodeFillColor
            nodeStrokeColor = builder.nodeStrokeColor ?? nodeStrokeColor
            nodeHighLightFillColor = builder.nodeHighLightFillColor ?? nodeHighLightStrokeColor
            nodeHighLightStrokeColor = builder.nodeHighLightStrokeColor ?? nodeHighLightStrokeColor
            lineColor = builder.lineColor ?? lineColor
            lineWidth = builder.lineWidth ?? lineWidth
            backgroundColor = builder.backgroundColor ?? backgroundColor
            rowCount = builder.rowCount ?? rowCount
            columnCount = builder.columnCount ?? columnCount
            spaceBetweenNodes = builder.spaceBetweenNodes ?? spaceBetweenNodes

        }
        
        public class Builder {
            var nodeFillColor:UIColor?
            var nodeStrokeColor:UIColor?
            var nodeHighLightFillColor:UIColor?
            var nodeHighLightStrokeColor:UIColor?
            var lineColor:UIColor?
            var lineWidth:CGFloat?
            var backgroundColor:UIColor?
            var rowCount:Int?
            var columnCount:Int?
            var spaceBetweenNodes:CGFloat?
           
            public init(){
                
            }
            
            public func setNodeFillColor(_ nodeFillColor:UIColor)->Builder{
                self.nodeFillColor = nodeFillColor
                return self
            }
            public func setNodeStrokeColor(_ nodeStrokeColor:UIColor)->Builder{
                self.nodeStrokeColor = nodeStrokeColor
                return self
            }
            public func setNodeHighLightFillColor(_ nodeHighLightFillColor:UIColor)->Builder{
                self.nodeHighLightFillColor = nodeHighLightFillColor
                return self
            }
            public func setNodeHighLightStrokeColor(_ nodeHighLightStrokeColor:UIColor)->Builder{
                self.nodeHighLightStrokeColor = nodeHighLightStrokeColor
                return self
            }
            public func setLineColor(_ lineColor:UIColor)->Builder{
                self.lineColor = lineColor
                return self
            }
            public func setLineWidth(_ lineWidth:CGFloat)->Builder{
                self.lineWidth = lineWidth
                return self
            }
            public func setBackgroundColor(_ backgroundColor:UIColor)->Builder{
                self.backgroundColor = backgroundColor
                return self
            }
            
            public func setRowCount(_ rowCount:Int)->Builder{
                self.rowCount = rowCount
                return self
            }
            public func setColumnCount(_ columnCount:Int)->Builder{
                self.columnCount = columnCount
                return self
            }
            public func setSpaceBetweenNodes(_ spaceBetweenNodes:CGFloat)->Builder{
                self.spaceBetweenNodes = spaceBetweenNodes
                return self
            }
          
            public func build()->Config{
                return Config(builder: self)
            }
        }
        
    }
}
