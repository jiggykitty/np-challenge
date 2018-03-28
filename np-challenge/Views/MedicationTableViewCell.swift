//
//  MedicationTableViewCell.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/27/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameField: UILabel!
    
    @IBAction func infoButtonPressed(_ sender: Any) {
    }
    
    var medication: Medication?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameField.layer.borderWidth = 2.0
        nameField.layer.zPosition = -1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
