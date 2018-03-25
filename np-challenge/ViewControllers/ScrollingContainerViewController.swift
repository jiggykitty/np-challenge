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
        
        // Add welcome view with name input
        let welcomeScreen = Bundle.main.loadNibNamed("WelcomeScreen", owner: self, options: nil)?.first as! WelcomeScreen
        welcomeScreen.delegate = self
        welcomeScreen.frame = CGRect(x: welcomeScreen.frame.origin.x, y: 100, width: welcomeScreen.frame.width, height: welcomeScreen.frame.height)
        scrollView.addSubview(welcomeScreen)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    extension ScrollingContainerViewController: ScrollableForm {
        func passName(name: String) {
            self.patient = Patient(name)
        }
}
