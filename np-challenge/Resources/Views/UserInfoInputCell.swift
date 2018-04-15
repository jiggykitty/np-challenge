//
//  UserInfoInputCell.swift
//  np-challenge
//
//  Created by Cagri Sahan on 4/14/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

class UserInfoInputCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
