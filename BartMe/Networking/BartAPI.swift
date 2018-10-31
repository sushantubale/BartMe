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

    static func getBartData() {
        
        URLSession.shared.dataTask(with: bartURL!) { (data, response, error) in
            if error == nil {
                
                print("data = \(String(describing: data))")
                print("response = \(response.debugDescription)")
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: data!, options: [])
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    print("The todo is: " + todo.description)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
                
            else {
                print("no data")
            }
            }.resume()
    }
}
