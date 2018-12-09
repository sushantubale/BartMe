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
    @IBOutlet weak var stationListTableView: UITableView!
    var stationLists: [String]?
    var stationName: [String]?
    var station1TextFieldSelected: Bool? = true
    lazy var abbrevationsStringsArray: [String] = []
    var finalDestinationTimes: [String] = []
    var abbrevationsShortform: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AdditionalUIHelper.addGif(view: self.view, resource: "giftrain_1")

        let findButton = SimpleButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        findButton.setTitle("Find All Routes", for: .normal)
        view.addSubview(findButton)
        findButton.setBorderWidth(2.0, for: .normal)
        findButton.setBorderColor(.black, for: .normal)
        findButton.addTarget(self, action: #selector(getAllRoutesButttonClicked), for: UIControlEvents.touchDown)
        findButton.translatesAutoresizingMaskIntoConstraints = false
        findButton.topAnchor.constraint(equalTo: getAllrouteTextfield.topAnchor, constant: 100).isActive = true
        findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        getAllrouteTextfield.textAlignment = .center
        getAllrouteTextfield.delegate = self
        getAllrouteTextfield.attributedPlaceholder = NSAttributedString(string: "BART station name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        getAllrouteTextfield.tag = 0
        getAllrouteTextfield.layer.cornerRadius = 0.5
        getAllrouteTextfield.layer.borderWidth = 0.5

        stationListTableView.isHidden = true
        getAllrouteTextfield.addTarget(self, action: #selector(stationTextfieldAction), for: UIControlEvents.touchDown)
        BartAPI.getStationList { (bartModel) in
            self.assignStationLists(bartModel: bartModel)
        }
    }
    
    func assignStationLists(bartModel: BartModel) {
        
        stationLists = bartModel.cityAbbrevations
        stationName = bartModel.cityName
        DispatchQueue.main.async {
            self.stationListTableView.reloadData()
        }
    }

    @IBAction func getAllRoutesButttonClicked(_ sender: Any) {
        
        guard let getAllrouteTextfield = getAllrouteTextfield else {return}
        if ((getAllrouteTextfield.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Alert!!!!", message: "Please select a valid BART station for the routes.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] action in
                switch action.style{
                case .default:
                    self?.getAllrouteTextfield.shake()
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
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
            
            for station in (model.enumerated()) {
                
                var inAll: [String] = []

                for k in station.element.estimates.enumerated() {
                    
                    inAll.append(k.element.minutes)
                }
                var inAll2 = inAll.joined(separator: " , ")
                self?.abbrevationsShortform.append(station.element.abbreviation)
                self?.finalDestinationTimes.append(inAll2)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.destinationTimes = (self?.finalDestinationTimes)!
            vc.abbrevationsNames = (self?.abbrevationsShortform)!
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
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
