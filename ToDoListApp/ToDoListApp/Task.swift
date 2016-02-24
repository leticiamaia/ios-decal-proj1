//
//  Task.swift
//  ToDoListApp
//
//  Created by Leticia Maia on 2/22/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    // MARK: Properties
    
    struct PropertyKey {
        static let taskNameKey = "taskName"
        static let isCompletedKey = "isCompleted"
        static let  isImportantKey = " isImportant"
        static let completionTimeKey = "completionTime"
        static let expirationIntervalKey = "expirationInterval"
    }
    
    var taskName: String
    var isCompleted: Bool = false
    var completionTime: NSDate? = nil
    var isImportant: Bool = false
    let expirationInterval: NSTimeInterval = 60*60*24 //1 Day
    
    init(taskName: String, isImportant: Bool) {
        self.taskName = taskName
        self.isImportant = isImportant
    }
    
    init(taskName: String, isCompleted: Bool, isImportant: Bool, completionTime: NSDate?) {
        self.taskName = taskName
        self.isCompleted = isCompleted
        self.completionTime = completionTime
        self.isImportant = isImportant
    }
    
    func expirationTime()-> NSDate {
        return completionTime!.dateByAddingTimeInterval(expirationInterval)
    }
    
    func isExpired() -> Bool {
        if isCompleted && (expirationTime().compare(NSDate()) ==  NSComparisonResult.OrderedAscending) {
           return true
        }
        return false
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(taskName, forKey: PropertyKey.taskNameKey)
        aCoder.encodeObject(isCompleted, forKey: PropertyKey.isCompletedKey)
        aCoder.encodeObject(completionTime, forKey: PropertyKey.completionTimeKey)
        aCoder.encodeObject(isImportant, forKey: PropertyKey.isImportantKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let taskName = aDecoder.decodeObjectForKey(PropertyKey.taskNameKey) as! String
        let isCompleted = aDecoder.decodeObjectForKey(PropertyKey.isCompletedKey) as! Bool
        let isImportant = aDecoder.decodeObjectForKey(PropertyKey.isImportantKey) as! Bool
        let completionTime = aDecoder.decodeObjectForKey(PropertyKey.completionTimeKey) as! NSDate?
        self.init(taskName: taskName, isCompleted: isCompleted, isImportant: isImportant, completionTime: completionTime)
    }
}
