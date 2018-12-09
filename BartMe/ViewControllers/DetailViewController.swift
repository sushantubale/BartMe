//
//  DetailViewController.swift
//  BartMe
//
//  Created by Sushant Ubale on 11/4/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UIBarPositioningDelegate {
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var detailViewNavigationController: UINavigationBar!
    
    var destinationTimes: [String] = []
    var abbrevationsNames: [String]? = []
    var containsDetailInfo = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            self.detailViewNavigationController.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
                ).isActive = true
        } else {
            self.detailViewNavigationController.topAnchor.constraint(
                equalTo: topLayoutGuide.bottomAnchor
                ).isActive = true
        }
        self.detailViewNavigationController.delegate = self
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.destinationTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.destinationTimes[indexPath.row]
        if self.containsDetailInfo {
        cell.detailTextLabel?.text = self.abbrevationsNames![indexPath.row]
        }
        else {
            cell.detailTextLabel?.text = ""
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
