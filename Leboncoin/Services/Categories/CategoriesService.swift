//
//  CategoriesService.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation
import Combine

// MARK: - CategoriesService

protocol CategoriesServiceProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }

    func fetchCategories() -> AnyPublisher<[AnnouncementCategory], Error>
}

final class CategoriesService: CategoriesServiceProtocol {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCategories() -> AnyPublisher<[AnnouncementCategory], Error> {
        let endpoint = Endpoint.categories
        
        return networkService.get(
            type: [AnnouncementCategory].self,
            url: endpoint.url,
            headers: endpoint.headers
        )
    }
}
