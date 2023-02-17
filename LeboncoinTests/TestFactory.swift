//
//  AnnouncementsFactory.swift
//  LeboncoinTests
//
//  Created by Renxiao Mo on 17/02/2023.
//

@testable import Leboncoin

private extension String {
   static func random(of n: Int = 10) -> String {
      let digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
      return String(Array(0..<n).compactMap { _ in digits.randomElement() })
   }
}

struct TestFactory {
    static func createAnnouncement() -> Announcement {
        return Announcement(
            id: Int.random(in: 1...123456789),
            categoryId: Int.random(in: 1...11),
            title: String.random(),
            description: String.random(),
            price: Float.random(in: 1...10),
            imageUrls: [:],
            creationDate: "",
            isUrgent: false,
            siret: nil
        )
    }
    
    static func createCategory() -> AnnouncementCategory {
        return AnnouncementCategory(id: Int.random(in: 1...11), name: String.random())
    }
}
