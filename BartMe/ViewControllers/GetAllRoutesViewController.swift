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
        
        BartAPI.singleRoute(self.getAllrouteTextfield.text) { [weak self] (routeModel) in
            
            guard let routeModel = routeModel else {
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//            vc.destinationTimes = routeModel.destinationTimes
//            vc.destination = routeModel.destination
//            vc.originTimes = routeModel.originTimes
//            vc.origin = routeModel.origin
//            vc.tripTime = routeModel.tripTime
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
            
            if let currentCell1 = currentCell?.detailTextLabel?.text, let currentCell2 = currentCell?.textLabel?.text {
                self.getAllrouteTextfield.text =  "\(currentCell2)" 

            }
            self.stationListTableView.isHidden = true
            self.view.layoutIfNeeded()
        }
        
        
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
