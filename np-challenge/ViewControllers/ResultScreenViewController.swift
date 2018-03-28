//
//  ResultScreenViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/27/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class ResultScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: IBActions
    @IBAction func addMedsButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: parentVC!.addMedication)
    }
    
    // MARK: Variables
    var patient: Patient?
    var parentVC: ScrollableForm?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = "\(patient?.name ?? "Patient")'s Results"
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        for item in patient!.prescriptions {
            print(item)
            print(item.name)
        }
    }
    
}

// MARK: Extensions
extension ResultScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patient!.prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as! MedicationTableViewCell
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.nameField.text = patient!.prescriptions[indexPath.row].name
        return cell
    }
}
