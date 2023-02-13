//
//  AnnouncementCellViewModel.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation

struct AnnouncementCellViewModel {
    private let announcement: Announcement
    
    var title: String {
        announcement.title
    }
    
    var price: String {
        "\(announcement.price)"
    }
    
    var category: String {
        "\(announcement.categoryId)"
    }
    
    var creationDate: String {
        announcement.creationDate
    }
    
    init(announcement: Announcement) {
        self.announcement = announcement
    }
}
