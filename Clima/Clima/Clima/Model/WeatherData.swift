//
//  WeatherData.swift
//  Clima
//
//  Created by Nouran Adel on 7/27/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
//-----------file essential for JSON Decoding------------------
//struct should match the file properties we're decoding & property names have to be the same as the ones in the file we want to extract
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable{
    let description: String
    let id: Int
}
