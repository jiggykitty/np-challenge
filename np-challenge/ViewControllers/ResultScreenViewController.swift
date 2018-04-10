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
    
    // MARK: Functions
    func showInfo(sender: MedicationTableViewCell) {
        let vc = DrugInfoViewController(nibName: "DrugInfoView", bundle: nil)
        vc.modalPresentationStyle = .popover
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = sender
        popover.sourceRect = sender.bounds
        
        vc.delegate = self
        vc.medication = sender.medication!
        self.present(vc, animated: true, completion: nil)
    }
    
    func deletePrescription(_ prescription: Medication) {
        patient?.removePrescription(prescription)
        self.tableView.reloadData()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        nameField.text = "\(patient?.name ?? "Patient")'s Results"
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDataSegue" {
            let vc = segue.destination as! DataScreenViewController
            vc.patient = patient
            vc.parentVC = self
            print("yarrak")
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
        cell.medication = patient!.prescriptions[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ResultScreenViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        if self.traitCollection.verticalSizeClass == .regular {
        return UIModalPresentationStyle.none
        }
        else {
            return UIModalPresentationStyle.fullScreen
        }
    }
}
