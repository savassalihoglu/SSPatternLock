//
//  ViewController.swift
//  SSPatternLock
//
//  Created by mustafasavassalihoglu@gmail.com on 09/29/2020.
//  Copyright (c) 2020 mustafasavassalihoglu@gmail.com. All rights reserved.
//

import UIKit
import SSPatternLock

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let patternLockView = SSPatternLockView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        patternLockView.delegate = self
        
        patternLockView.config = SSPatternLockView.Config.Builder()
            .setBackgroundColor(UIColor.white)
            .setNodeFillColor(UIColor.black)
            .setNodeHighLightFillColor(UIColor.clear)
            .setNodeHighLightStrokeColor(UIColor.black)
            .setSpaceBetweenNodes(30)
            .setLineColor(UIColor.black)
            .setLineWidth(15)
            .build()
        
        self.view.addSubview(patternLockView)
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : SSPatternLockDelegate {
    func patternLockSelected(_ patternLockView: SSPatternLockView, _ selectedIndexes: [Int]) {
        selectedIndexes.forEach({ print("index: \($0)") })
    }
}

