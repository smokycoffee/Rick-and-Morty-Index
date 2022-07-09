//
//  RMCharacterInfo.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 25/6/22.
//

import Foundation

struct RMCharacterInfo: Codable, Hashable {

    let name: String
    let status: String
    let species: String
    let gender: String
    var origin: Origins
    
    struct Origins: Codable, Hashable {
        let name: String
        var url: String
    }
    var location: Location
    
    struct Location: Codable, Hashable {
        let name: String
        var url: String
    }
    
    
    let image: String
    let created: String
}
 

