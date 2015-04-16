//
//  DetailViewController.swift
//  TaskItWatch
//
//  Created by David Pirih on 16.04.15.
//  Copyright (c) 2015 Piri-Piri. All rights reserved.
//

import UIKit
import CoreDataShare

class DetailViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViewWithTask()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func saveBarButtonItemPressed(sender: UIBarButtonItem) {
        task.titleName = self.titleTextView.text
        task.descriptionName = self.bodyTextView.text
        CoreDataManager.sharedInstance.saveContext()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        TaskHelper.sharedInstance.switchCompletion(self.task)
        
        if task.isCompleted.boolValue {
            doneButton.backgroundColor = UIColor.greenColor()
            doneButton.setTitle("✘", forState: UIControlState.Normal)
        }
        else {
            doneButton.backgroundColor = UIColor.redColor()
            doneButton.setTitle("✔︎", forState: UIControlState.Normal)
        }
    }
    
    // MARK: - Helper
    
    func setupViewWithTask() {
        self.titleTextView.text = task.titleName
        self.bodyTextView.text = task.description
        
        if task.isCompleted.boolValue {
            doneButton.backgroundColor = UIColor.greenColor()
            doneButton.setTitle("✘", forState: UIControlState.Normal)
        }
        else {
            doneButton.backgroundColor = UIColor.redColor()
            doneButton.setTitle("✔︎", forState: UIControlState.Normal)
        }
        
    }
}
