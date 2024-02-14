//
//  GenericModel.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 13/02/24.
//

import Foundation
struct Generic: Codable {
    let count: Int
    let entries: [Entry]
}

// MARK: - Entry
struct Entry: Codable {
    let api, description, auth: String
    let https: Bool
    let cors: String
    let link: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case api = "API"
        case description = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}
