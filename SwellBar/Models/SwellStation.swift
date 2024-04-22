//
//  StationList.swift
//  SwellBar
//
//  Created by Rick Sutherland on 4/23/24.
//

import Foundation

struct SwellStation: Codable {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
}
