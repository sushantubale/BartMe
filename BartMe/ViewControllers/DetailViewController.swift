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
    
    var origin: [String]? = []
    var destination: [String]? = []
    var originTimes: [String]? = []
    var destinationTimes: [String]? = []
    var routeFare: [String]? = []
    var tripTime: [String]? = []

    
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
//        self.detailViewNavigationController.topItem?.title = "\(origin) - \(destination)"
    
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.destinationTimes?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let origDest = "\(originTimes![indexPath.row]) - \(destinationTimes![indexPath.row])"
        cell.textLabel?.text = origDest
        cell.detailTextLabel?.text = tripTime?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
