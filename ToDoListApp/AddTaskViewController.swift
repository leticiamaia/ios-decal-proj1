//
//  AddTaskViewController.swift
//  ToDoListApp
//
//  Created by Leticia Maia on 2/21/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var priorityUISwich: UISwitch!
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         saveButton.enabled = false
        taskNameTextField.addTarget(self, action: "checkFieldEmpty", forControlEvents: .EditingChanged)
        // Do any additional setup after loading the view.
        priorityUISwich.setOn(false, animated: false)
    }
    
    func checkFieldEmpty() {
        if taskNameTextField.text != nil && taskNameTextField.text!.isEmpty {
            saveButton.enabled = false
        } else {
            saveButton.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton === sender {
            let name: String = taskNameTextField.text ?? ""
            let isImportant = priorityUISwich.on
            task = Task(taskName: name, isImportant: isImportant)
        }
    }
    

}
