//
//  Coord.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import Foundation


struct Coord : Codable {
    let lat : Double?
    let lon : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lon = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
    }
    
}
