//
//  CategoriesManager.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 14/02/2023.
//

import Combine

protocol CategoriesProvider: AnyObject {
    var categories: [AnnouncementCategory] { get set }
}

class CategoriesManager: CategoriesProvider {
    
    static let shared = CategoriesManager()
    var categories = [AnnouncementCategory]()
    
    private init() {}
}
