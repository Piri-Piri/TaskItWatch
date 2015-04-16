//
//  InterfaceController.swift
//  TaskItWatch WatchKit Extension
//
//  Created by David Pirih on 16.04.15.
//  Copyright (c) 2015 Piri-Piri. All rights reserved.
//

import WatchKit
import Foundation
import CoreDataShare

class InterfaceController: WKInterfaceController, TaskRowDelegate {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    var tasks: [AnyObject]!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        updateTasks()
        updateTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateTable() {
        if self.tasks.count > 0 {
            self.table.setNumberOfRows(self.tasks.count, withRowType: "TaskRow")
            
            for var index = 0; index < tasks.count; index++ {
                var row = self.table.rowControllerAtIndex(index) as! TaskRow
                
                let task = self.tasks[index] as! Task
                row.textLabel.setText(task.titleName)
                row.completion = task.isCompleted as Bool
                row.tag = index
                
                /* Set delegate for each row to switch the completion by the watch app */
                row.delegate = self
                
                if task.isCompleted.boolValue {
                    row.completionButton.setBackgroundColor(UIColor.greenColor())
                }
                else {
                    row.completionButton.setBackgroundColor(UIColor.redColor())
                }
            }
        }
    }
    
    func updateTasks() {
        self.tasks = TaskHelper.sharedInstance.getTasks()
    }
    
    // MARK: - TaskRowDelegate
    
    func completedButtonWasPressed(tag: Int) {
        var task = tasks[tag] as! Task
        TaskHelper.sharedInstance.switchCompletion(task)
    }
}
