//
//  AnnouncementCellViewModel.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation

struct AnnouncementCellViewModel {
    private let announcement: Announcement
    
    var categoryId: String {
        "\(announcement.categoryId)"
    }
    
    var creationDate: String {
        guard let date = DateFormatter.serverDateFormatter.date(from: announcement.creationDate) else {
            return ""
        }
              
        return DateFormatter.dayMonthHourMinFormatter.string(from: date)
    }
    
    var imageUrl: String? {
        announcement.imageUrls["small"]
    }
    
    var price: String {
        "\(announcement.price.clean) €"
    }
    
    var title: String {
        announcement.title
    }
    
    init(announcement: Announcement) {
        self.announcement = announcement
    }
    
    func loadImage(completion: @escaping (Data?, Error?) -> Void) {
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
        DataLoader().loadData(url: url) { data, error in
            completion(data, error)
        }
    }
}
