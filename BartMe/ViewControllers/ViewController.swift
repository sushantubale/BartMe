//
//  ViewController.swift
//  BartMe
//
//  Created by Sushant Ubale on 10/29/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var stationLists: [String]?
    var stationName: [String]?
    var station1TextField = UITextField()
    var station2TextField = UITextField()
    var station1TextFieldSelected: Bool?
    var station1NameForRoute: String?
    var station2NameForRoute: String?
    
    
    @IBOutlet weak var stationTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        stationTableView.isHidden = true
        BartAPI.getStationList { [weak self] (bartModel) in
            self?.assignStationLists(bartModel: bartModel)
        }
        renderUI()
    }

    func assignStationLists(bartModel: BartModel) {
        
        stationLists = bartModel.cityAbbrevations
        stationName = bartModel.cityName
        DispatchQueue.main.async {
            self.stationTableView.reloadData()
        }
    }
    
    func renderUI() {
        
        station1TextField.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        view.addSubview(station1TextField)
        station1TextField.addTarget(self, action: #selector(stationTextfieldAction), for: UIControlEvents.touchDown)
        station1TextField.tag = 0
        station1TextField.delegate = self
        station1TextField.translatesAutoresizingMaskIntoConstraints = false
        station1TextField.placeholder = "Bart station 1"
        station1TextField.layer.cornerRadius = 4.0
        station1TextField.layer.borderWidth = 2.0
        station1TextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        station1TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        station1TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        station2TextField.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        view.addSubview(station2TextField)
        station2TextField.addTarget(self, action: #selector(stationTextfieldAction), for: UIControlEvents.touchDown)
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
        findButton.addTarget(self, action: #selector(getRoute), for: UIControlEvents.touchDown)
        findButton.backgroundColor = UIColor.brown
        findButton.translatesAutoresizingMaskIntoConstraints = false
        findButton.titleLabel?.text = "Find Route"
        findButton.topAnchor.constraint(equalTo: station2TextField.topAnchor, constant: 100).isActive = true
        findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    @objc func getRoute() {

        BartAPI.getRoute(self.station1NameForRoute, self.station2NameForRoute) { [weak self] (routeModel) in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.destinationTimes = routeModel.destinationTimes
            vc.destination = routeModel.destination
            vc.originTimes = routeModel.originTimes
            vc.origin = routeModel.origin
            vc.tripTime = routeModel.tripTime
            DispatchQueue.main.async {
                self?.present(vc, animated: true, completion: nil)

            }

            
        }

    }
    
    @objc func stationTextfieldAction() {
        
        DispatchQueue.main.async {
            self.stationTableView.reloadData()
        }

        UIView.animate(withDuration: 0.5) {
            self.stationTableView.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - UITextfielDelegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 0 {
            station1TextFieldSelected = true
        }
        else {
            station1TextFieldSelected = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stationLists?.count ?? 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = stationTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stationLists?[indexPath.row]
        cell.detailTextLabel?.text = stationName?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        stationTableView.deselectRow(at: indexPath, animated: true)
        UIView.animate(withDuration: 0.5) {
            let currentCell = self.stationTableView.cellForRow(at: indexPath)
            guard let station1TextFieldSelected = self.station1TextFieldSelected else { return }
            
            if station1TextFieldSelected {
                self.station1TextField.text = currentCell?.detailTextLabel?.text
                self.station1NameForRoute = currentCell?.textLabel?.text
            }
            else {
                self.station2TextField.text = currentCell?.detailTextLabel?.text
                self.station2NameForRoute = currentCell?.textLabel?.text
            }
            
            self.stationTableView.isHidden = true
            self.view.layoutIfNeeded()
        }


    }

    }
    

