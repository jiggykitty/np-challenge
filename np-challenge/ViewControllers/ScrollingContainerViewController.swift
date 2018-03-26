//
//  ScrollingContainerViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/25/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class ScrollingContainerViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var nxLogo: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Variables
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keep logo floating
        nxLogo.layer.zPosition = 1
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Add welcome view with name input
        let welcomeScreen = Bundle.main.loadNibNamed("WelcomeScreen", owner: self, options: nil)?.first as! WelcomeScreen
        welcomeScreen.delegate = self
        welcomeScreen.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(welcomeScreen)
        
        welcomeScreen.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        welcomeScreen.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        welcomeScreen.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        welcomeScreen.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
    }

    func add
}

    extension ScrollingContainerViewController: ScrollableForm {
        func passName(name: String) {
            patient = Patient(name)
        }
}
