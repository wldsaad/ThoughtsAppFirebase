//
//  ViewController.swift
//  RndmTrial1
//
//  Created by Waleed Saad on 11/30/18.
//  Copyright © 2018 Waleed Saad. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //OUTLETS
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //VARIABLES
    private var thoughts = [ThoughtModel]()
    private var category: String = categories.Funny.rawValue
    private var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120.0
//        tableView.estimatedRowHeight = 80.0
//        tableView.rowHeight = UITableView.automaticDimension
        db = Firestore.firestore()
        initFirebase()

        
    }
    
    //CHANGE SETTINGS OF FIREBASE
    private func initFirebase(){
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        loadThoughts()
    }
    
    //LOAD ALL THOUGHTS STORED IN FIREBSTORE DB
    private func loadThoughts(){
        db.collection(THOUGHTS_COLLECTION).getDocuments { (querySnapshots, error) in
            if let error = error {
                debugPrint("ERROR HAPPENED \(error.localizedDescription)")
                return
            } else {
                guard let snaps = querySnapshots else {
                    return
                }
                self.thoughts.removeAll()
                for document in snaps.documents {
                    let data = document.data()
                    let author = data["author"] as? String ?? "No Author"
                    let timestamp = data["timestamp"] as? Date ?? Date()
                    let thought = data["thought"] as? String ?? "No Thought"
                    let thoughtObject = ThoughtModel(author: author, timestamp: timestamp, thought: thought)
                    self.thoughts.append(thoughtObject)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    //FILTER CATEGORIES SELECTION
    @IBAction func segmentedActionChanged(_ sender: UISegmentedControl) {
        let categorySelected: String = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        if categorySelected == sender.titleForSegment(at: 0){
            loadThoughts()
            return
        }
        db.collection(THOUGHTS_COLLECTION).whereField("category", isEqualTo: categorySelected).getDocuments { (querySnapshots, error) in
            if let error = error {
                debugPrint("ERROR HAPPENED \(error.localizedDescription)")
                return
            } else {
                guard let snaps = querySnapshots else {
                    return
                }
                self.thoughts.removeAll()
                for document in snaps.documents {
                    let data = document.data()
                    let author = data["author"] as? String ?? "No Author"
                    let timestamp = data["timestamp"] as? Date ?? Date()
                    let thought = data["thought"] as? String ?? "No Thought"
                    let thoughtObject = ThoughtModel(author: author, timestamp: timestamp, thought: thought)
                    self.thoughts.append(thoughtObject)
                }
                self.tableView.reloadData()
            }
        }
    }
    
}


//EXTENSIONS
//TABLEVIEW DATASOURCE
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtsCell", for: indexPath) as? ThoughtsCell {
            cell.updateViews(thought: thoughts[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        return ThoughtsCell()
    }
}

//TABLEVIEW DELEGATE
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedThought = thoughts[indexPath.row]
        performSegue(withIdentifier: "thoughtSegue", sender: selectedThought)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let thoughtVC = segue.destination as? ThoughtVC {
            thoughtVC.updateThought(thought: sender as! ThoughtModel)
        }
    }
}
