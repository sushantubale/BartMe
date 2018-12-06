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
    var destinationTimes: [String] = []
    var routeFare: [String]? = []
    var tripTime: [String]? = []

}

struct Estimate: Decodable {
    let minutes: String
    private enum CodingKeys: String, CodingKey {
        case minutes
    }
}

struct Etd: Decodable {
    let destination: String
    let abbreviation: String
    let estimates: [Estimate]
    private enum CodingKeys: String, CodingKey {
        case destination
        case abbreviation
        case estimates = "estimate"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        destination = try container.decode(String.self, forKey: .destination)
        abbreviation = try container.decode(String.self, forKey: .abbreviation)
        estimates = try container.decode([Estimate].self, forKey: .estimates)
    }
}

struct Station: Decodable {
    let name: String
    let abbr: String
    let etds: [Etd]
    private enum CodingKeys: String, CodingKey {
        case name
        case abbr
        case etds = "etd"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        abbr = try container.decode(String.self, forKey: .abbr)
        etds = try container.decode([Etd].self, forKey: .etds)
    }
}

struct Root: Decodable {
    let stations: [Station]
    private enum CodingKeys: String, CodingKey {
        case stations = "station"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stations = try container.decode([Station].self, forKey: .stations)
    }
}

struct DummyResponse: Decodable {
    let root: Root
    private enum CodingKeys: String, CodingKey {
        case root = "root"
    }
}
