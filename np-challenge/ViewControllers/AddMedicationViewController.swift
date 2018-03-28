//
//  AskMedicationViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/27/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//
import UIKit

class AddMedicationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchField: UnderlinedTextField!
    var dropDown: DropDownViewController?
    var delegate: MedicationPassable?
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if let medication = searchField.text {
            if medication != "" {
                self.delegate?.passMedication(searchField.text!)
            }
        }
    }
    
    override func viewDidLoad() {
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(openDropDown), for: UIControlEvents.editingDidBegin)
        searchField.addTarget(self, action: #selector(updateText), for: UIControlEvents.editingChanged)
        searchField.spellCheckingType = .no
    }
    
    @objc func openDropDown() {
        dropDown = DropDownViewController(style: .plain)
        dropDown?.delegate = self
        addChildViewController(dropDown!)
        let parentFrame = searchField.frame
        dropDown!.view.translatesAutoresizingMaskIntoConstraints = false
        dropDown!.view.frame = CGRect(x: parentFrame.minX, y: parentFrame.maxY, width: parentFrame.width, height: 100)
        self.view.addSubview(dropDown!.view)
        dropDown!.didMove(toParentViewController: self)
    }
    
    @objc func updateText() {
        dropDown?.textField = searchField.text ?? ""
    }
}

extension AddMedicationViewController: MedicationPassable {
    func passMedication(_ name: String) {
        self.searchField.text = name
        self.searchField.resignFirstResponder()
        dropDown?.willMove(toParentViewController: nil)
        dropDown?.view.removeFromSuperview()
        dropDown?.removeFromParentViewController()
    }
}
