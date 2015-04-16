//
//  ViewController.swift
//  TaskItWatch
//
//  Created by David Pirih on 15.04.15.
//  Copyright (c) 2015 Piri-Piri. All rights reserved.
//

import UIKit
import CoreData
import CoreDataShare


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var fetchResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupFetchResultsController()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailTaskSegue" {
            var detailVC = segue.destinationViewController as! DetailViewController
            detailVC.task = sender as! Task
        }
    }


    @IBAction func addTaskBarButtonItemPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("toAddTaskSegue", sender: nil)
    }
    
    // MARK: - FetchResultsController Helper
    
    func setupFetchResultsController() {
        var fetchRequest = NSFetchRequest()
        
        let entityDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        fetchRequest.entity = entityDescription
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        self.fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        var error: NSError? = nil
        if !self.fetchResultsController.performFetch(&error) {
            println("Error while fetching results: \(error)")
        }
        
    }
    
    // MARK: - UITableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        var task = self.fetchResultsController.objectAtIndexPath(indexPath) as! Task
        
        cell.textLabel!.text = task.titleName
        
        if task.isCompleted.boolValue {
            cell.backgroundColor = UIColor.greenColor()
        }
        else {
            cell.backgroundColor = UIColor.redColor()
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var task = fetchResultsController.objectAtIndexPath(indexPath) as! Task
        self.performSegueWithIdentifier("toDetailTaskSegue", sender: task)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let task = self.fetchResultsController.objectAtIndexPath(indexPath) as! Task
            TaskHelper.sharedInstance.deleteTask(task)
        }
        
    }
    
    // MARK: - FetchResultsController Delegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
}

