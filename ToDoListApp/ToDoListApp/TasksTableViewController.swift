//
//  TasksTableViewController.swift
//  ToDoListApp
//
//  Created by Leticia Maia on 2/20/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    @IBOutlet weak var statsBarButtonItem: UIBarButtonItem!
    let defaults = NSUserDefaults.standardUserDefaults()
    let tasksKey = "tasksKey"
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadTasks()
    }
    
    func loadTasks() {
        if let decodedTasks = defaults.objectForKey(tasksKey) as? NSData {
            self.tasks = NSKeyedUnarchiver.unarchiveObjectWithData(decodedTasks) as! [Task]
        } else {
            tasks += [Task(taskName: "Hello Leticia")]
        }
        
    }
    
    func saveTasks() {
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(tasks), forKey: tasksKey)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        for i in tasks.indices.reverse() {
            if tasks[i].isExpired() {
                tasks.removeAtIndex(i)
            }
        }
        saveTasks()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TaskCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        if(task.isCompleted) {
            let attributes = [NSStrikethroughStyleAttributeName: 1]
            let attributedTaskName = NSAttributedString(string: task.taskName, attributes: attributes)
            cell.taskName.attributedText = attributedTaskName
        } else {
            cell.taskName.text = task.taskName
        }
        return cell
    }
  

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {action in
            self.editing = false
            self.tasks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.saveTasks()
            self.tableView.reloadData()
        }
        let checkTaskDone = UITableViewRowAction(style: .Normal, title: "Done") { (action, indexPath) in
            self.editing = false
            let task = self.tasks[indexPath.row]
            if(!task.isCompleted) {
                task.isCompleted = true
                task.completionTime = NSDate()
            }
            self.saveTasks()
            self.tableView.reloadData()

        }
        checkTaskDone.backgroundColor = UIColor.greenColor()
        return [checkTaskDone, deleteAction]
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(sender === statsBarButtonItem) {
            loadTasks()
            let nav = segue.destinationViewController as! UINavigationController
            let destinationViewController = nav.topViewController as! StatsViewController
            var counter: Int = 0
            for task in tasks {
              if task.isCompleted {
                counter += 1
              }
            }
            destinationViewController.numberOfExpiredTasks = counter
        }
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddTaskViewController, task = sourceViewController.task {
            let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
            tasks.append(task)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            saveTasks()
        }
    }

}
