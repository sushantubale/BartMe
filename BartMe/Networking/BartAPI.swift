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
                    completionHandler(bartModel)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            else { print("no data") }
            }.resume()
    }
    
    static func specificRoute(_ station1: String?,_ station2: String?, completionHandler: @escaping (SpeceficRouteModel) -> Void) {
    
        let routeURL = URL(string: "http://api.bart.gov/api/sched.aspx?cmd=arrive&orig=\(station1 ?? "12TH")&dest=\(station2 ?? "24TH")&date=now&key=MW9S-E7SL-26DU-VV8V&b=2&a=2&l=1&json=y")
        
        var routeModel = SpeceficRouteModel()
        
        URLSession.shared.dataTask(with: routeURL!) { (data, response, error) in
            if error == nil {
                
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    //print("todo = \(todo)")
                    let root = todo["root"] as? [String: Any]
                    let schedule = root?["schedule"] as? [String: Any]
                    let request = schedule?["request"] as? [String: Any]
                    let trip = request?["trip"] as? [[String: Any]]

                    for (key, value) in (trip?.enumerated())! {
                        routeModel.destinationTimes?.append(value["@destTimeMin"] as! String)
                        routeModel.originTimes?.append(value["@origTimeMin"] as! String)
                        routeModel.destination?.append(value["@destination"] as! String)
                        routeModel.origin?.append(value["@origin"] as! String)
                        routeModel.tripTime?.append(value["@tripTime"] as! String)
                    }
                    completionHandler(routeModel)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            else { print("no data") }
            }.resume()

    }
    
    static func singleRoute(_ station: String?, completionHandler: @escaping (SingleRouteModel) -> Void) {
        
        let routeURL = URL(string: "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=\(station ?? "12TH")&key=MW9S-E7SL-26DU-VV8V&json=y")
        
        var routeModel = SingleRouteModel()

        URLSession.shared.dataTask(with: routeURL!) { (data, response, error) in
            if error == nil {
                
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    print("todo = \(todo)")
                    let root = todo["root"] as? [String: Any]
                    let station = root?["station"] as? [[String: Any]]
                    var etd: [[String : Any]]?
                    for (_, value) in (station?.enumerated())! {
                        
                        print(value["abbr"])
                        print(value["name"])
                        print(value["etd"])
                        etd = value["etd"] as? [[String: Any]]
                    }
                    

                    for (key1, value1) in (etd?.enumerated())! {
                        
                        print(value1)
                        print(value1["estimate"])
                        
                    }
                    
                    
                    completionHandler(routeModel)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            else { print("no data") }
            }.resume()
        
    }
}
