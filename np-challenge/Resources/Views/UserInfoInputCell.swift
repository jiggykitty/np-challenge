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
        dataInput.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UserInfoInputCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true;
    }
}
