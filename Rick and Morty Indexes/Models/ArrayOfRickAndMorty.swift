//
//  RickAndMortyArray.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 22/6/22.
//

import Foundation

struct ArrayOfRickAndMorty: Codable, Hashable{
    let results: [Results]
    
    
    struct Results: Codable, Hashable {
        var name: String
        var image: String
        var id: Int
    }
}



