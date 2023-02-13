//
//  AnnouncementsViewModel.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Combine

final class AnnouncementsViewModel: ObservableObject {
    
    // MARK: - Properties

    private let announcementsService = AnnouncementsService(networkService: NetworkService())
    private var cancellables = Set<AnyCancellable>()
    
    @Published var announcements = [Announcement]()
    
    // MARK: - Get data
    
    func getAnnouncements() {
        announcementsService.getAnnouncements()
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
}
