//
//  ThoughtsCell.swift
//  RndmTrial1
//
//  Created by Waleed Saad on 11/30/18.
//  Copyright © 2018 Waleed Saad. All rights reserved.
//

import UIKit

class ThoughtsCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thoughtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews(thought: ThoughtModel){
        authorLabel.text = thought.author
        timeLabel.text = thought.timestamp.description
        thoughtLabel.text = thought.thought
    }

}
