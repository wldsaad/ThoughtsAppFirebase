//
//  AddThoughtVC.swift
//  RndmTrial1
//
//  Created by Waleed Saad on 11/30/18.
//  Copyright © 2018 Waleed Saad. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController {

    
    //OUTLETs
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var thoughtText: UITextView!
    
    //VARIABLEs
    private var db: Firestore!
    private var category = categories.Funny.rawValue
    private var actionSheet: UIAlertController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        configFirestoreSettings()

    }
    
    //SET CATEGORY TITLE
    @IBAction func segmentAction(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            category = categories.Funny.rawValue
            break
        case 1:
            category = categories.Serious.rawValue
            break
        case 2:
            category = categories.Crazy.rawValue
            break
        default:
            category = categories.Popular.rawValue
        }
    }
    
    //CHANGE FIREBASE SETTINGS
    private func configFirestoreSettings(){
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }

    //POST NEW THOUGHT ACTION
    @IBAction func postAction(_ sender: Any) {
        guard let auth = authorText.text, auth.count > 0,
        let thought = thoughtText.text, thought.count > 0 else {
            return
        }
        let dataToPost:[String: Any] = [
            AUTHOR_NAME: auth,
            THOUGHT: thought,
            TIMESTAMP: FieldValue.serverTimestamp(),
            NUM_LIKES: 0,
            NUM_COMMENTS: 0,
            CATEGORY: category
        ]
        
        db.collection(THOUGHTS_COLLECTION).addDocument(data: dataToPost) { (error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            } else {
                self.navigationController?.popViewController(animated: true)
                debugPrint("Printed Successfully")
            }
        }

    }

}
