//
//  TaskTableViewCell.swift
//  ToDoListApp
//
//  Created by Leticia Maia on 2/21/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
