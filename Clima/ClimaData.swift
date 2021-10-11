//
//  ClimaData.swift
//  Clima
//
//  Created by marco rodriguez on 11/10/21.
//

import Foundation

struct ClimaData: Codable {
    let name: String
    let temp: Int
    let main: Main
    //let coord: NSFileCoordinator
    //let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}
