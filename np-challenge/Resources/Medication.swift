//
//  Medication.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/25/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

class Medication: Codable {
    let name: String
    let description: String?
    
    init(name: String, description: String?) {
        self.name = name
        self.description = description
    }
}

extension Medication: Equatable {
    static func == (lhs: Medication, rhs: Medication) -> Bool {
        return lhs.name == rhs.name
    }
}
