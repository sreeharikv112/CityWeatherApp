//
//  Weather.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import Foundation

struct Weather : Codable {
    let icon : String?
    let description : String?
    let main : String?
    let id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case icon = "icon"
        case description = "description"
        case main = "main"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
}
