//
//  AskMedicationViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/27/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class AskMedicationViewController: UIViewController {
    
    // MARK: IBActions
    @IBAction func yesButtonPressed(_ sender: Any) {
        delegate!.addMedication()
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        delegate!.moveToResults()
    }
    
    // MARK: Variables
    var delegate: ScrollableForm?
}
