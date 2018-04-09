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
    var prescriptions = [Medication]()
    
    public init(_ name: String) {
        self.name = name
    }
    
    public func addPrescription(_ name: String) {
        // Here, get medicine information from openFDA
        let medication = Medication(name: name, description: nil)
        self.prescriptions.append(medication)
    }
    
    public func removePrescription(_ prescription: Medication) {
        prescriptions = prescriptions.filter { $0 != prescription }
    }
}
