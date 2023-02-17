//
//  LeboncoinTests.swift
//  LeboncoinTests
//
//  Created by Renxiao Mo on 13/02/2023.
//

import XCTest
@testable import Leboncoin

class AnnouncementViewModelTests: XCTestCase {
    
    func testPropertiesAreFormattedCorrectly() {
        let mock = Announcement(
            id: 123,
            categoryId: 3,
            title: "Title",
            description: "Description",
            price: 140.00,
            imageUrls: [
                "small": "https://raw.githubusercontent.com/small.jpg",
                "thumb": "https://raw.githubusercontent.com/thumb.jpg"
            ],
            creationDate: "2019-11-05T15:56:59+0000",
            isUrgent: false)
        let viewModel = AnnouncementViewModel(announcement: mock, categoriesProvider: MockCategoriesProvider())
        
        XCTAssertEqual(viewModel.category, "Bricolage")
        XCTAssertEqual(viewModel.creationDate, "5 novembre 15:56")
        XCTAssertEqual(viewModel.description, "Description")
        XCTAssertEqual(viewModel.isUrgent, false)
        XCTAssertEqual(viewModel.smallImageUrl, "https://raw.githubusercontent.com/small.jpg")
        XCTAssertEqual(viewModel.bigImageUrl, "https://raw.githubusercontent.com/thumb.jpg")
        XCTAssertEqual(viewModel.price, "140 €")
        XCTAssertEqual(viewModel.title, "Title")
    }
}

class MockCategoriesProvider: CategoriesProvider {
    var categories: [AnnouncementCategory] = [
        AnnouncementCategory(id: 1, name: "Véhicule"),
        AnnouncementCategory(id: 2, name: "Mode"),
        AnnouncementCategory(id: 3, name: "Bricolage")
    ]
}
