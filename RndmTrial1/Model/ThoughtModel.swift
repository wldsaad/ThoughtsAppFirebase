//
//  ThoughtModel.swift
//  RndmTrial1
//
//  Created by Waleed Saad on 11/30/18.
//  Copyright © 2018 Waleed Saad. All rights reserved.
//

import Foundation
import Firebase

struct ThoughtModel {
    var author: String
    var timestamp: Date
    var thought: String
    
    init(author: String, timestamp: Date, thought: String) {
        self.author = author
        self.timestamp = timestamp
        self.thought = thought
    }
}
