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
    var currentView: UIView?
    var delegate: MedicationPassable?
    
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
        
        currentView = welcomeScreen
    }
    
    func addNextView(_ nextView: UIView) {
        nextView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(nextView)
        
        nextView.topAnchor.constraint(equalTo: currentView!.bottomAnchor, constant: 0).isActive = true
        nextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        nextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        nextView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -250).isActive = true
        currentView = nextView
        
        scrollView.layoutIfNeeded()
        scrollView.scrollToBottom(animated: true)
    }
    
    func askMedication() {
        let vc = AskMedicationViewController(nibName: "AddMedicationView", bundle: nil)
        self.addChildViewController(vc)
        vc.delegate = self
        addNextView(vc.view)
        vc.willMove(toParentViewController: self)
    }
}

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}

extension ScrollingContainerViewController: MedicationPassable {
    func passMedication(_ name: String) {
        self.patient?.addMedication(name)
    }
}

extension ScrollingContainerViewController: ScrollableForm {
    func passName(name: String) {
        patient = Patient(name)
        askMedication()
    }
}
