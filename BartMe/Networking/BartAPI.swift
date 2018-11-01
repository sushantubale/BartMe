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
    static let bartModel = BartModel()
    
    static func getStationList(completionHandler: @escaping ([String]) -> Void) {
        
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
                        BartModel.cityAbbrevations.append(value["abbr"] as! String)
                    }
                    
                    completionHandler(BartModel.cityAbbrevations)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            else { print("no data") }
            }.resume()
    }
}
