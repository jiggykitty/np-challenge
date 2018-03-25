//
//  File.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/25/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

class Patient {
    let name: String
    var email: String?
    var phone: String?
    var prescriptions: [Medication]?
    
    public init(_ name: String) {
        self.name = name
    }
}
