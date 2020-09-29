//
//  PLDrawItem.swift
//  SSPatternLock
//
//  Created by Savaş Salihoğlu on 23.09.2020.
//

import UIKit

protocol PLDrawItem  {
    var path:UIBezierPath { get set }
    var fillColor:UIColor { get set }
    var strokeColor:UIColor { get set }
    func draw()
}
