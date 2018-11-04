//
//  BartAPI.swift
//  BartMe
//
//  Created by Sushant Ubale on 10/29/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import Foundation

class BartAPI {
    
    static let bartURL = URL(string:"https://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V&json=y")
    
    static func getStationList(completionHandler: @escaping (BartModel) -> Void) {
        
        let bartModel = BartModel()
        
        URLSession.shared.dataTask(with: bartURL!) { (data, response, error) in
            if error == nil {
                
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    let root = todo["root"] as? [String: Any]
                    let stations = root!["stations"] as? [String: Any]
                    let station = stations!["station"] as? [[String: Any]]
                    
                    for (_, value) in (station?.enumerated())! {
                            bartModel.cityAbbrevations.append(value["abbr"] as! String)
                            bartModel.cityCity.append(value["city"] as! String)
                            bartModel.cityCounty.append(value["county"] as! String)
                            bartModel.cityZipcode.append(value["zipcode"] as! String)
                            bartModel.cityName.append(value["name"] as! String)
                            bartModel.cityState.append(value["city"] as! String)
                            bartModel.cityAddress.append(value["address"] as! String)
                    }
                    print("bartModel values = \(bartModel)")
                    completionHandler(bartModel)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            else { print("no data") }
            }.resume()
    }
    
    static func getRoute(_ station1: String?,_ station2: String?) {
    
        let routeURL = "http://api.bart.gov/api/sched.aspx?cmd=arrive&orig=\(station1)&dest=\(station2)&date=now&key=MW9S-E7SL-26DU-VV8V&b=2&a=2&l=1&json=y"
        
        URLSession.shared.dataTask(with: bartURL!) { (data, response, error) in
            if error == nil {
                
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
//                    completionHandler(bartModel)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            else { print("no data") }
            }.resume()

    }
}
