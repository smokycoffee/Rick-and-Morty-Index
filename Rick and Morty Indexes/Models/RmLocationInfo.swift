//
//  RmLocationInfo.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 5/7/22.
//

import Foundation

struct RmLocationInfo: Codable, Hashable {

    let name: String
    let type: String
    let dimension: String
    var residents: [String]
    
    let created: String
}
