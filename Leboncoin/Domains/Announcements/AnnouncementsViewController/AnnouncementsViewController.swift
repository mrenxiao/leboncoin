//
//  AnnouncementsViewController.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Combine
import UIKit

final class AnnouncementsViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: MenuViewControllerDelegate?
    private let viewModel = AnnouncementsViewModel(
        announcementsService: AnnouncementsService(networkService: NetworkService()),
        categoriesService: CategoriesService(networkService: NetworkService()),
        categoriesProvider: CategoriesManager.shared
    )
    
    // MARK: - Init
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        title = "Leboncoin"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: AnnouncementCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCategories { [weak self] in
            self?.viewModel.fetchAnnouncements()
        }
        bindViewModel()
    }
    
    // MARK: - Update UI
    
    private func bindViewModel() {
        viewModel.$announcements
            .receive(on: DispatchQueue.main)
            .sink { [weak self] values in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.announcements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementCell.identifier, for: indexPath) as? AnnouncementCell else {
            return UITableViewCell()
        }

        let item = viewModel.announcements[indexPath.row]
        cell.configure(with: AnnouncementViewModel(announcement: item, categoriesProvider: viewModel.categoriesProvider))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.announcements[indexPath.row]
        delegate?.didTapMenuItem(announcement: item)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AnnouncementCell.Constant.cellHeight
    }
}
