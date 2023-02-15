//
//  Announcement.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation

struct Announcement: Codable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Float
    let imageUrls: [String: String]
    let creationDate: String
    let isUrgent: Bool
    var siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case imageUrls = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}
