//
//  RMError.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 23/6/22.
//

import Foundation

enum RMError: String, Error {
    case invalidUrlLink     = "This link created an invalid request. Please try again"
    case unableToComplete   = "Unable to complete request. Please check your internet connection"
    case invalidResponse    = "Invalid response from server. Please try again"
    case invalidData        = "The data received from server was invalid. Please try again."
}
