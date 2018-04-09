//
//  DrugInfoViewController.swift
//  np-challenge
//
//  Created by Cagri Sahan on 4/9/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class DrugInfoViewController: UIViewController {
    
    @IBOutlet weak var drugName: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var closeButton: RoundButton!
    @IBOutlet weak var deleteButton: RoundButton!
    @IBOutlet weak var container: UIView!
    
    // MARK: Variables
    var delegate: ResultScreenViewController?
    var medication: Medication? {
        didSet {
            loadDrugInfo()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.delegate!.deletePrescription(medication!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.layer.borderWidth = 2.0
        container.layer.zPosition = -1
        drugName.text = medication?.name
        textView.text = "No data found"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDrugInfo() {
        let name = medication?.name
        let path = "https://api.fda.gov/drug/label.json?search=brand_name:\(name!)"
        let url = URL(string: path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { [unowned self] (data, response, error) in
            guard error == nil else { return }
            guard data != nil else { return }
            
            let decoder = JSONDecoder()
            let results = try! decoder.decode(Results.self, from: data!)
            
            DispatchQueue.main.async {
                self.textView.text = results.results![0].indications_and_usage?.joined(separator: "\n")
            }
        }
        task.resume()
    }
}
