//
//  AnnouncementsViewModelTests.swift
//  LeboncoinTests
//
//  Created by Renxiao Mo on 17/02/2023.
//

import XCTest
import Combine
@testable import Leboncoin

enum TestError: Error {
    case error
}

class AnnouncementsViewModelTests: XCTestCase {

    var announcementsService: MockAnnouncementsService!
    var categoriesService: MockCategoriesService!
    var categoriesManager: MockCategoriesManager!
    var sut: AnnouncementsViewModel!
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        announcementsService = MockAnnouncementsService()
        categoriesService = MockCategoriesService()
        categoriesManager = MockCategoriesManager()

        sut = AnnouncementsViewModel(
            announcementsService: announcementsService,
            categoriesService: categoriesService,
            categoriesProvider: categoriesManager)
    }
    
    // MARK: - Fetch announcements
    
    func testFetchAnnouncements_OK() {
        
        // Given
        let announcements: [Announcement] = [
            TestFactory.createAnnouncement(),
            TestFactory.createAnnouncement(),
            TestFactory.createAnnouncement()
        ]
        announcementsService.fetchResult = CurrentValueSubject(announcements).eraseToAnyPublisher()
        let promise = expectation(description: "Fetching announcements")
        
        // When
        sut.fetchAnnouncements()

        // Then
        sut.$announcements
            .sink { values in
                if values.count == 3 {
                    promise.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [promise], timeout: 1)
    }
    
    func testFetchAnnouncements_KO() {

        // Given
        let error = TestError.error
        announcementsService.fetchResult = Fail(error: error).eraseToAnyPublisher()
        let promise = expectation(description: "Fetching announcements")

        // When
        sut.fetchAnnouncements()

        // Then
        sut.$announcements
            .sink { values in
                if values.count == 0 {
                    promise.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [promise], timeout: 1)
    }
    
    // MARK: - Fetch categories
    
    func testFetchCategories_OK() {

        // Given
        let categories: [AnnouncementCategory] = [
            TestFactory.createCategory(),
            TestFactory.createCategory(),
            TestFactory.createCategory(),
            TestFactory.createCategory()
        ]
        categoriesService.fetchResult = CurrentValueSubject(categories).eraseToAnyPublisher()
        let promise = expectation(description: "Fetching categories")

        // When
        sut.fetchCategories {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)

        // Then
        XCTAssertEqual(categoriesManager.categories.count, 4)
    }
    
    func testFetchCategories_KO() {

        // Given
        let error = TestError.error
        categoriesService.fetchResult = Fail(error: error).eraseToAnyPublisher()
        let promise = expectation(description: "Fetching categories")

        // When
        sut.fetchCategories {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)

        // Then
        XCTAssertEqual(categoriesManager.categories.count, 0)
    }
}
