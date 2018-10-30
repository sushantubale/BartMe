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
        
        BartAPI.getBartData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

