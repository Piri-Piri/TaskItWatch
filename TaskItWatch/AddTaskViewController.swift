//
//  AddTaskViewController.swift
//  TaskItWatch
//
//  Created by David Pirih on 16.04.15.
//  Copyright (c) 2015 Piri-Piri. All rights reserved.
//

import UIKit
import CoreDataShare

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func saveBarButtonItemPressed(sender: UIBarButtonItem) {
        TaskHelper.sharedInstance.insertNewObject(self.titleTextView.text, description: self.bodyTextView.text, date: NSDate())
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   

}
