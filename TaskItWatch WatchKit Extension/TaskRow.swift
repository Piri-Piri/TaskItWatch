//
//  TaskRow.swift
//  TaskItWatch
//
//  Created by David Pirih on 16.04.15.
//  Copyright (c) 2015 Piri-Piri. All rights reserved.
//

import UIKit
import WatchKit

protocol TaskRowDelegate {
    func completedButtonWasPressed(tag: Int)
}

class TaskRow: NSObject {
    
    var completion: Bool!
    var tag: Int!
    
    var delegate: TaskRowDelegate?
    
    @IBOutlet weak var completionButton: WKInterfaceButton!
    @IBOutlet weak var textLabel: WKInterfaceLabel!
    
    
    @IBAction func completionButtonPressed() {
        if completion.boolValue {
            completion = !completion
            completionButton.setBackgroundColor(UIColor.redColor())
        }
        else {
            completion = !completion
            completionButton.setBackgroundColor(UIColor.greenColor())
        }
        self.delegate?.completedButtonWasPressed(tag)
    }
    
}
