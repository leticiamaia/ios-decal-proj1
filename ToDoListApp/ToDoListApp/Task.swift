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
        static let completionTimeKey = "completionTime"
        static let expirationIntervalKey = "expirationInterval"
    }
    
    var taskName: String
    var isCompleted: Bool = false
    var completionTime: NSDate? = nil
    let expirationInterval: NSTimeInterval = 60*60*24 //1 Day
    
    init(taskName: String) {
        self.taskName = taskName
    }
    
    init(taskName: String, isCompleted: Bool, completionTime: NSDate?) {
        self.taskName = taskName
        self.isCompleted = isCompleted
        self.completionTime = completionTime
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
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let taskName = aDecoder.decodeObjectForKey(PropertyKey.taskNameKey) as! String
        let isCompleted = aDecoder.decodeObjectForKey(PropertyKey.isCompletedKey) as! Bool
        let completionTime = aDecoder.decodeObjectForKey(PropertyKey.completionTimeKey) as! NSDate?
        self.init(taskName: taskName, isCompleted: isCompleted, completionTime: completionTime)
    }
}
