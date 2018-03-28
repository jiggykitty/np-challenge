//
//  DropDownViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/27/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import Foundation

class DropDownViewController: UITableViewController {
    
    var delegate: MedicationPassable?
    var results = [String]()
    var textField: String = "" {
        didSet {
            getSuggestions(term: textField)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.passMedication(results[indexPath.row])
    }
    
    func getSuggestions(term: String) {
        let urlString = "http://ec2-54-162-72-84.compute-1.amazonaws.com/complete.php?Name=\(term)"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { [unowned self] (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            self.results = try! decoder.decode([String].self, from: data)
            
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
}
