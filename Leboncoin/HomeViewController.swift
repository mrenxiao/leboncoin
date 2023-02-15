//
//  ViewController.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    private let splitVC = UISplitViewController(style: .doubleColumn)
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitVC.delegate = self
        view.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        splitVC.view.backgroundColor = .white
        splitVC.preferredDisplayMode = .oneBesideSecondary
        
        let menuViewController = AnnouncementsViewController(style: .plain)
        menuViewController.delegate = self

        let welcomeViewController = WelcomeViewController()
        welcomeViewController.view.backgroundColor = .white
        
        splitVC.viewControllers = [
            UINavigationController(rootViewController: menuViewController),
            UINavigationController(rootViewController: welcomeViewController)
        ]
        
        welcomeViewController.navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(splitVC.view)
    }
}

// MARK: - UISplitViewControllerDelegate

extension HomeViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}

// MARK: - MenuViewControllerDelegate

extension HomeViewController: MenuViewControllerDelegate {
    func didTapMenuItem(announcement: Announcement) {
        let viewController = AnnouncementDetailViewController(
            viewModel: AnnouncementViewModel(
                announcement: announcement,
                categoriesProvider: CategoriesManager.shared)
        )
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            (splitVC.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
            (splitVC.viewControllers.last as? UINavigationController)?.pushViewController(viewController, animated: true)
        case .pad:
            (splitVC.viewControllers.last as? UINavigationController)?.setViewControllers([viewController], animated: false)
        default: break
        }
    }
}

protocol MenuViewControllerDelegate: AnyObject {
    func didTapMenuItem(announcement: Announcement)
}
