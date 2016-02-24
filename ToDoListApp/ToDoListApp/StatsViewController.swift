//
//  StatsViewController.swift
//  ToDoListApp
//
//  Created by Leticia Maia on 2/22/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var numberOfExpiredTasksLabel: UILabel!
    
    var numberOfExpiredTasks: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfExpiredTasksLabel.text = String(numberOfExpiredTasks)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
