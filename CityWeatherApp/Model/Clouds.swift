//
//  Clouds.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import Foundation


struct Clouds : Codable {
    let all : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case all = "all"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decodeIfPresent(Int.self, forKey: .all)
    }
    
}
