//
//  AnnouncementsService.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation
import Combine

// MARK: - AnnouncementsService

protocol AnnouncementsServiceProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }

    func getAnnouncements() -> AnyPublisher<[Announcement], Error>
}

final class AnnouncementsService: AnnouncementsServiceProtocol {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getAnnouncements() -> AnyPublisher<[Announcement], Error> {
        let endpoint = Endpoint.announcements
        
        return networkService.get(
            type: [Announcement].self,
            url: endpoint.url,
            headers: endpoint.headers
        )
    }
}
