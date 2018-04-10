//
//  DataScreenViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 4/9/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit
import MessageUI

class DataScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var drugTable: UITableView!
    @IBOutlet weak var currentProfileLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func addMedsButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            self.parentVC?.dismiss(animated: true) {
                self.parentVC?.parentVC?.addMedication()
            }
        }
    }
    
    @IBAction func viewResultsButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendEmailButtonPressed(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setSubject("Your patient info")
            composer.setMessageBody("Hi \(patient!.name),\n Here is your data file", isHTML: false)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(patient!)
            composer.addAttachmentData(data, mimeType: "application/json", fileName: "patientData")
            self.present(composer, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Mail not configured", message: "Cannot send mail.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController() as! ScrollingContainerViewController
        self.present(rootVC, animated: false, completion: { rootVC.showSplashScreen() })
    }
    
    // MARK: Variables
    
    var patient: Patient?
    var dataDict = [String:String]()
    var parentVC: ResultScreenViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTable.layer.borderWidth = 2.0
        drugTable.layer.borderWidth = 2.0
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: currentProfileLabel.frame.size.width, height: 2.0)
        topBorder.backgroundColor = UIColor.black.cgColor
        currentProfileLabel.layer.addSublayer(topBorder)
        
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: 0.0, y: 0.0, width: 2.0, height: currentProfileLabel.frame.size.height)
        leftBorder.backgroundColor = UIColor.black.cgColor
        currentProfileLabel.layer.addSublayer(leftBorder)
        
        let rightBorder = CALayer()
        rightBorder.frame = CGRect(x: currentProfileLabel.frame.size.width - 2.0, y: 0.0, width: 2.0, height: currentProfileLabel.frame.size.height)
        rightBorder.backgroundColor = UIColor.black.cgColor
        currentProfileLabel.layer.addSublayer(rightBorder)
        
        dataTable.dataSource = self
        drugTable.dataSource = self
        
        nameLabel.text = "\(patient?.name ?? "Patient")'s Data"
        dataDict["Name"] = patient?.name ?? ""
        dataDict["Email"] = patient?.email ?? ""
        dataDict["Telephone"] = patient?.phone ?? ""
        
        dataTable.reloadData()
        drugTable.reloadData()
    }
}

extension DataScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dataTable {
            return 3
        }
        else {
            return patient!.prescriptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dataTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
            let index = dataDict.index(dataDict.startIndex, offsetBy: indexPath.row)
            print(index)
            print(dataDict.keys)
            cell.textLabel?.text = dataDict.keys[index]
            cell.detailTextLabel?.text = dataDict.values[index]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath)
            cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.textLabel?.text = patient?.prescriptions[indexPath.row].name
            return cell
        }
    }
}

extension DataScreenViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
