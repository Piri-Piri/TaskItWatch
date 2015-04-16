//
//  Task.swift
//  TaskItWatch
//
//  Created by David Pirih on 16.04.15.
//  Copyright (c) 2015 Piri-Piri. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

    @NSManaged public var date: NSDate
    @NSManaged public var descriptionName: String
    @NSManaged public var isCompleted: NSNumber
    @NSManaged public var titleName: String

}
