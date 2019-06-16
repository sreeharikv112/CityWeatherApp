//
//  WeatherJSONData.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import Foundation

struct WeatherJSONData : Codable {
    let main : Main?
    let id : Int?
    let coord : Coord?
    let weather : [Weather]?
    let wind : Wind?
    let visibility : Int?
    let dt : Int?
    let base : String?
    let cod : Int?
    let name : String?
    let timezone : Int?
    let sys : Sys?
    let clouds : Clouds?
    
    enum CodingKeys: String, CodingKey {
        
        case main = "main"
        case id = "id"
        case coord = "coord"
        case weather = "weather"
        case wind = "wind"
        case visibility = "visibility"
        case dt = "dt"
        case base = "base"
        case cod = "cod"
        case name = "name"
        case timezone = "timezone"
        case sys = "sys"
        case clouds = "clouds"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
    }
    
}
