//
//  Mocks.swift
//  LeboncoinTests
//
//  Created by Renxiao Mo on 17/02/2023.
//

import Foundation
import Combine
@testable import Leboncoin

class MockNetworkService: NetworkServiceProtocol {
    func get<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}

class MockAnnouncementsService: AnnouncementsServiceProtocol {
    var networkService: NetworkServiceProtocol = MockNetworkService()
    var fetchResult: AnyPublisher<[Announcement], Error>?
    
    func fetchAnnouncements() -> AnyPublisher<[Announcement], Error> {
        guard let result = fetchResult else {
            fatalError("Result must not be nil")
        }
        return result
    }
}

class MockCategoriesService: CategoriesServiceProtocol {
    var networkService: NetworkServiceProtocol = MockNetworkService()
    var fetchResult: AnyPublisher<[AnnouncementCategory], Error>?
    
    func fetchCategories() -> AnyPublisher<[AnnouncementCategory], Error> {
        guard let result = fetchResult else {
            fatalError("Result must not be nil")
        }
        return result
    }
}

class MockCategoriesManager: CategoriesProvider {
    var categories = [AnnouncementCategory]()
}
