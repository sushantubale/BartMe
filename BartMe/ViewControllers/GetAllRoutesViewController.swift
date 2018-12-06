//
//  GetAllRoutesViewController.swift
//  BartMe
//
//  Created by Sushant Ubale on 11/8/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import UIKit

class GetAllRoutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var getAllrouteTextfield: UITextField!
    @IBOutlet weak var getAllrouteButton: UIButton!
    @IBOutlet weak var stationListTableView: UITableView!
    var stationLists: [String]?
    var stationName: [String]?
    var station1TextFieldSelected: Bool? = true
    lazy var abbrevationsStringsArray: [String] = []
    var finalDestinationTimes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationListTableView.isHidden = true
        getAllrouteTextfield.addTarget(self, action: #selector(stationTextfieldAction), for: UIControlEvents.touchDown)
        BartAPI.getStationList { (bartModel) in
            self.assignStationLists(bartModel: bartModel)

        }
        
        // Do any additional setup after loading the view.
    }
    
    func assignStationLists(bartModel: BartModel) {
        
        stationLists = bartModel.cityAbbrevations
        stationName = bartModel.cityName
        DispatchQueue.main.async {
            self.stationListTableView.reloadData()
        }
    }

    @IBAction func getAllRoutesButttonClicked(_ sender: Any) {
        
        var index = 0
        BartAPI.singleRoute(self.getAllrouteTextfield.text) { [weak self] (routeModel) in
            
            guard let model = routeModel else {
                let alert = UIAlertController(title: "Alert!!!!", message: "No data matched your criteria. Or the BART systems are currently down. We apologize for inconveniene.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
                return
            }
            guard let routeModel = routeModel else {return}
            
            for station in (routeModel.enumerated()) {
                
                var inAll: [String] = []

                for k in station.element.estimates.enumerated() {
                    
                    inAll.append(k.element.minutes)
                }
                var inAll2 = inAll.joined(separator: ",")
                inAll2.append("        min's to        ")
                inAll2.append(station.element.abbreviation)
                self?.finalDestinationTimes.append(inAll2)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.destinationTimes = (self?.finalDestinationTimes)!
            DispatchQueue.main.async {
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @objc func stationTextfieldAction() {
    
    DispatchQueue.main.async {
    self.stationListTableView.reloadData()
    }
    
    UIView.animate(withDuration: 0.5) {
    self.stationListTableView.isHidden = false
    self.view.layoutIfNeeded()
    }
    }

    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stationLists?.count ?? 48
    }
    
    func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let stationList = stationLists {
            let origDest = "\(stationList[indexPath.row])"
            cell.textLabel?.text = origDest
            cell.detailTextLabel?.text = stationName?[indexPath.row]

        }
        return cell
        
    }
    
    // MARK: - UITextfielDelegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        stationListTableView.deselectRow(at: indexPath, animated: true)
        UIView.animate(withDuration: 0.5) {
            let currentCell = self.stationListTableView.cellForRow(at: indexPath)
            
            if let _ = currentCell?.detailTextLabel?.text, let currentCell2 = currentCell?.textLabel?.text {
                self.getAllrouteTextfield.text =  "\(currentCell2)" 

            }
            self.stationListTableView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
}
