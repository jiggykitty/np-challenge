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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Results" {
            if let destination = segue.destination as? ResultScreenViewController {
                destination.patient = self.patient!
                destination.parentVC = self
            }
        }
    }
    
    // MARK: Lifecycle
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
        
        let topMargin: CGFloat
        if self.traitCollection.verticalSizeClass == .compact {
            topMargin = 50.0
        }
        else {
            topMargin = 100.0
        }
        
        welcomeScreen.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topMargin).isActive = true
        welcomeScreen.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        welcomeScreen.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        welcomeScreen.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
        
        currentView = welcomeScreen
    }
    
    // MARK: Functions
    func addNextView(_ nextView: UIView) {
        currentView?.isUserInteractionEnabled = false
        currentView?.alpha = 0.5
        
        nextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(nextView)
        
        nextView.topAnchor.constraint(equalTo: currentView!.bottomAnchor, constant: 0).isActive = true
        nextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        nextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        nextView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -200).isActive = true
        currentView = nextView
        
        scrollView.layoutIfNeeded()
        
        if self.traitCollection.verticalSizeClass == .compact {
            scrollToCurrentView(animated: true)
        }
        else {
            scrollView.scrollToBottom(animated: true)
        }
    }
    
    // I will use this to scroll to the current question when layout is changed
    func scrollToCurrentView(animated: Bool) {
        guard currentView != nil else { return }
        let viewMinYOffset = CGPoint(x: 0.0, y: currentView!.frame.minY)
        scrollView.setContentOffset(viewMinYOffset, animated: animated)
    }
}

// MARK: Extensions
extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}

extension ScrollingContainerViewController: ScrollableForm {
    func passName(name: String) {
        patient = Patient(name)
        addMedication()
    }
    
    func addMedication() {
        let vc = AddMedicationViewController(nibName: "AddMedicationView", bundle: nil)
        self.addChildViewController(vc)
        vc.delegate = self
        addNextView(vc.view)
        vc.willMove(toParentViewController: self)
    }
    
    func askMoreMeds() {
        let vc = AskMedicationViewController(nibName: "AskMedicationView", bundle: nil)
        self.addChildViewController(vc)
        vc.delegate = self
        addNextView(vc.view)
        vc.willMove(toParentViewController: self)
    }
    
    func moveToResults() {
        self.performSegue(withIdentifier: "Results", sender: self.patient)
    }
    
    func cancelInput() {
        askMoreMeds()
    }
    
    func passMedication(_ name: String) {
        self.patient?.addPrescription(name)
        askMoreMeds()
    }
}

extension ScrollingContainerViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        scrollToCurrentView(animated: false)
    }
}
