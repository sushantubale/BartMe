//
//  ViewController.swift
//  BartMe
//
//  Created by Sushant Ubale on 10/29/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var stationLists: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BartAPI.getStationList { [weak self] (bartModel) in
            self?.assignStationLists(BartModel.cityAbbrevations)
        }
        renderUI()
    }

    func assignStationLists(_ stationListValues: [String]) {
        print(stationListValues)
        self.stationLists = stationListValues
    }
    
    func renderUI() {
        
        let station1TextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        view.addSubview(station1TextField)
        station1TextField.tag = 0
        station1TextField.delegate = self
        station1TextField.translatesAutoresizingMaskIntoConstraints = false
        station1TextField.placeholder = "Bart station 1"
        station1TextField.layer.cornerRadius = 4.0
        station1TextField.layer.borderWidth = 2.0
        station1TextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        station1TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        station1TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        let station2TextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        view.addSubview(station2TextField)
        station2TextField.tag = 1
        station2TextField.delegate = self
        station2TextField.translatesAutoresizingMaskIntoConstraints = false
        station2TextField.placeholder = "Bart station 2"
        station2TextField.layer.cornerRadius = 4.0
        station2TextField.layer.borderWidth = 2.0
        station2TextField.topAnchor.constraint(equalTo: station1TextField.bottomAnchor, constant: 30).isActive = true
        station2TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        station2TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        let findButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        view.addSubview(findButton)
        findButton.backgroundColor = UIColor.brown
        findButton.translatesAutoresizingMaskIntoConstraints = false
        findButton.titleLabel?.text = "Find Route"
        findButton.topAnchor.constraint(equalTo: station2TextField.topAnchor, constant: 100).isActive = true
        findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textfield clicked = \(textField.tag)")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

}

