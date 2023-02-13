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

        let detailViewController = UIViewController()
        detailViewController.title = "Detail"
        detailViewController.view.backgroundColor = .white
        
        splitVC.viewControllers = [
            UINavigationController(rootViewController: menuViewController),
            UINavigationController(rootViewController: detailViewController)
        ]
        
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
    func didTapMenuItem(at index: Int, title: String?) {
        (splitVC.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.title = title
        
        (splitVC.viewControllers.last as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
}

protocol MenuViewControllerDelegate: AnyObject {
    func didTapMenuItem(at index: Int, title: String?)
}
