//
//  TabBarViewController.swift
//  BartMe
//
//  Created by Sushant Ubale on 12/6/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import UIKit
import TransitionableTab

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension TabBarViewController: TransitionableTab {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}
