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
    
    var name: String? {
        didSet {
            drugName.text = name
            loadDrugInfo()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDrugInfo() {
        let path = "https://api.fda.gov/drug/label.json?search=brand_name:\(name!)"
        let url = URL(string: path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { [unowned self] (data, response, error) in
            guard error == nil else { return }
            guard data != nil else { return }
            
            let decoder = JSONDecoder()
            let results = try! decoder.decode(Results.self, from: data!)
            print(results)
            
        }
        task.resume()
    }
    
    
}

extension RoundButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.red : UIColor.white
        }
    }
}
