//
//  ViewController.swift
//  BartMe
//
//  Created by Sushant Ubale on 10/29/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BartAPI.getBartData()
        renderUI()
    }

    func renderUI() {
        
        let station1TextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        self.view.addSubview(station1TextField)
        station1TextField.translatesAutoresizingMaskIntoConstraints = false

        station1TextField.backgroundColor = UIColor.blue
        station1TextField.placeholder = "Bart station 1"
        station1TextField.topAnchor.constraintLessThanOrEqualToSystemSpacingBelow(view.topAnchor, multiplier: -30).isActive = true
        station1TextField.leadingAnchor.constraintEqualToSystemSpacingAfter(view.leadingAnchor, multiplier: 30).isActive = true
        station1TextField.trailingAnchor.constraintEqualToSystemSpacingAfter(view.trailingAnchor, multiplier: 30).isActive = true
    }

}

