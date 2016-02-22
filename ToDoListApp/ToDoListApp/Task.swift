//
//  Task.swift
//  ToDoListApp
//
//  Created by Leticia Maia on 2/22/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import Foundation

class Task {
    // MARK: Properties
    
    var taskName: String
    var isCompleted: Bool = false
    var completionTime: NSDate? = nil
    let expirationInterval: NSTimeInterval = 60
    
    init(taskName: String) {
        self.taskName = taskName
    }
    
    func setIsCompleted(isCompleted: Bool) -> Void {
        self.isCompleted = isCompleted
    }
    
    func setCompletionTime(completionTime: NSDate) -> Void {
        self.completionTime = completionTime
    }
    
    func getTaskName() -> String {
        return self.taskName
    }
    
    func getIsCompleted() -> Bool {
        return self.isCompleted
    }
    
    func expirationTime()-> NSDate {
        return completionTime!.dateByAddingTimeInterval(expirationInterval)
    }
    
    func isExpired() -> Bool {
        if isCompleted && expirationTime().compare(NSDate()) ==  NSComparisonResult.OrderedAscending {
           return false
        }
        return true
    }
}
