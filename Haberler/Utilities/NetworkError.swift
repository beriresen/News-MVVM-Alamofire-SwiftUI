//
//  CustomError.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
