//
//  WelcomeScreen.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/25/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class WelcomeScreen: UIView {
    var delegate: ScrollableForm?
    
    @IBOutlet weak var nameField: UnderlinedTextField!
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        delegate!.passName(name: nameField.text ?? "")
    }
}
