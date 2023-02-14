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
    private let viewModel = AnnouncementsViewModel()
    
    // MARK: - Init
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        title = "Leboncoin"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAnnouncements()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AnnouncementCell else {
            return UITableViewCell()
        }

        let item = viewModel.announcements[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellText = tableView.cellForRow(at: indexPath)?.textLabel?.text
        delegate?.didTapMenuItem(at: indexPath.row, title: cellText)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AnnouncementCell.Constant.cellHeight
    }
}
