//
//  Main.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import Foundation

struct Main : Codable {
    let humidity : Int?
    let pressure : Int?
    let temp_max : Double?
    let temp : Double?
    let temp_min : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case humidity = "humidity"
        case pressure = "pressure"
        case temp_max = "temp_max"
        case temp = "temp"
        case temp_min = "temp_min"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
    }
    
}
