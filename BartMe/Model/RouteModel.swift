//
//  RouteModel.swift
//  BartMe
//
//  Created by Sushant Ubale on 11/4/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import Foundation

struct SpeceficRouteModel {
    
    var origin: [String]? = []
    var destination: [String]? = []
    var originTimes: [String]? = []
    var destinationTimes: [String]? = []
    var routeFare: [String]? = []
    var tripTime: [String]? = []

}

struct SingleRouteModel {
    
    var destination: [String]? = []
    var abbrevation: [String]? = []
    var minutes: [String]? = []


}
