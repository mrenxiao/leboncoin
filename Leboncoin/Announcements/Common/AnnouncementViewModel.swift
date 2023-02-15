//
//  AnnouncementCellViewModel.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation

struct AnnouncementViewModel {
    private let announcement: Announcement
    private let categoriesProvider: CategoriesProvider
    
    var category: String {
        categoriesProvider.categories.first(where: { $0.id == announcement.categoryId })?.name ?? ""
    }
    
    var creationDate: String {
        guard let date = DateFormatter.serverDateFormatter.date(from: announcement.creationDate) else {
            return ""
        }
              
        return DateFormatter.dayMonthHourMinFormatter.string(from: date)
    }
    
    var description: String {
        announcement.description
    }
    
    var smallImageUrl: String? {
        announcement.imageUrls["small"]
    }
    
    var bigImageUrl: String? {
        announcement.imageUrls["thumb"]
    }
    
    var isUrgent: Bool {
        announcement.isUrgent
    }
    
    var price: String {
        "\(announcement.price.clean) €"
    }
    
    var siret: String {
        announcement.siret ?? ""
    }
    
    var title: String {
        announcement.title
    }
    
    init(announcement: Announcement, categoriesProvider: CategoriesProvider) {
        self.announcement = announcement
        self.categoriesProvider = categoriesProvider
    }
    
    func loadImage(isSmall: Bool = true, completion: @escaping (Data?, Error?) -> Void) {
        let imageUrl = isSmall ? smallImageUrl : bigImageUrl
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
        DataLoader().loadData(url: url) { data, error in
            completion(data, error)
        }
    }
}
