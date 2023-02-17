//
//  AnnouncementsViewModel.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Combine

final class AnnouncementsViewModel: ObservableObject {
    
    // MARK: - Properties

    private let announcementsService: AnnouncementsServiceProtocol
    private let categoriesService: CategoriesServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    let categoriesProvider: CategoriesProvider
    @Published var announcements = [Announcement]()
    
    init(
        announcementsService: AnnouncementsServiceProtocol,
        categoriesService: CategoriesServiceProtocol,
        categoriesProvider: CategoriesProvider
    ) {
        self.announcementsService = announcementsService
        self.categoriesService = categoriesService
        self.categoriesProvider = categoriesProvider
    }
    
    // MARK: - Get data
    
    func fetchAnnouncements() {
        announcementsService.fetchAnnouncements()
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print("Couldn't get announcements: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] announcements in
                self?.announcements = announcements
            })
            .store(in: &cancellables)
    }
    
    func fetchCategories(completionHandler: (() -> Void)?) {
        categoriesService.fetchCategories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print("Couldn't get categories: \(error)")
                case .finished:
                    break
                }
                completionHandler?()
            }, receiveValue: { [weak self] categories in
                self?.categoriesProvider.categories = categories
                completionHandler?()
            })
            .store(in: &cancellables)
    }
}
