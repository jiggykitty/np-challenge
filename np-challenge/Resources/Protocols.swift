//
//  ScrollableForm.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/25/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

protocol ScrollableForm {
    func passName(name: String)
    func addMedication()
    func askMoreMeds()
    func moveToResults()
    func passMedication(_ name: String)
    func cancelInput()
}

protocol MedicationPassable {
    func passMedication(_ name: String)
}
