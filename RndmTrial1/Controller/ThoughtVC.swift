//
//  ThoughtVC.swift
//  RndmTrial1
//
//  Created by Waleed Saad on 12/2/18.
//  Copyright © 2018 Waleed Saad. All rights reserved.
//

import UIKit

class ThoughtVC: UIViewController {

    
    //OUTLETS
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thoughtLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    //VARIABLES
    private var thought: ThoughtModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        
    }
    
    //UPDATE VIEWS
    private func updateViews(){
        authorLabel.text = thought.author
        thoughtLabel.text = thought.thought
        dateLabel.text = thought.timestamp.description
    }
    
    //UPDATE MODEL TAKEN FROM PREVIOUS SCREEN
    func updateThought(thought: ThoughtModel){
        self.thought = thought
    }


}
