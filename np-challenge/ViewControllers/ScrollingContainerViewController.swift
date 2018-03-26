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
        
        // Add welcome view with name input
        let welcomeScreen = Bundle.main.loadNibNamed("WelcomeScreen", owner: self, options: nil)?.first as! WelcomeScreen
        welcomeScreen.delegate = self
        welcomeScreen.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(welcomeScreen)
        
        welcomeScreen.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 300)
        welcomeScreen.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        welcomeScreen.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        welcomeScreen.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    extension ScrollingContainerViewController: ScrollableForm {
        func passName(name: String) {
            patient = Patient(name)
        }
}
