//
//  LeboncoinTests.swift
//  LeboncoinTests
//
//  Created by Renxiao Mo on 13/02/2023.
//

import XCTest
@testable import Leboncoin

class AnnouncementCellViewModelTests: XCTestCase {
    
    func testPropertiesAreFormattedCorrectly() {
        let mock = Announcement(
            id: 123,
            categoryId: 1,
            title: "Title",
            description: "Description",
            price: 140.00,
            imageUrls: [
                "small": "https://raw.githubusercontent.com/small.jpg",
                "thumb": "https://raw.githubusercontent.com/thumb.jpg"
            ],
            creationDate: "2019-11-05T15:56:59+0000",
            isUrgent: false)
        let viewModel = AnnouncementCellViewModel(announcement: mock)
        
        XCTAssertEqual(viewModel.categoryId, "1")
        XCTAssertEqual(viewModel.creationDate, "5 novembre 15:56")
        XCTAssertEqual(viewModel.imageUrl, "https://raw.githubusercontent.com/small.jpg")
        XCTAssertEqual(viewModel.price, "140 €")
        XCTAssertEqual(viewModel.title, "Title")
    }
}
