//
//  AnnouncementDetailViewController.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 14/02/2023.
//

import Foundation
import UIKit

final class AnnouncementDetailViewController: UIViewController {

    // MARK: - Constant
    
    enum Constant {
        static let imageHeight: CGFloat = 300
        static let padding: CGFloat = 16
        static let separatorHeight: CGFloat = 1
    }
    
    // MARK: - Outlets
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var headerTextView: HeaderTextView = {
        let view = HeaderTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var siretView: SiretView = {
        let view = SiretView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let viewModel: AnnouncementViewModel
    
    // MARK: - Init

    init(viewModel: AnnouncementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .label
        view.backgroundColor = .white
        addSubviews()
        addSiretViewIfNeeded()
        updateUI()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(headerTextView)
        headerTextView.viewModel = viewModel
        
        let separatorView = createSeparatorView()
        verticalStackView.addArrangedSubview(separatorView)
        verticalStackView.addArrangedSubview(descriptionLabel)
    
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight).isActive = true
        
        separatorView.heightAnchor.constraint(equalToConstant: Constant.separatorHeight).isActive = true
        
        verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constant.padding).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constant.padding).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constant.padding).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constant.padding).isActive = true
        verticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(2 * Constant.padding)).isActive = true
    }
    
    private func addSiretViewIfNeeded() {
        guard !viewModel.siret.isEmpty else { return }
        
        let separatorView = createSeparatorView()
        verticalStackView.addArrangedSubview(separatorView)
        verticalStackView.addArrangedSubview(siretView)
        separatorView.heightAnchor.constraint(equalToConstant: Constant.separatorHeight).isActive = true
        
        siretView.siret = viewModel.siret
    }
    
    private func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func updateUI() {
        descriptionLabel.text = viewModel.description

        viewModel.loadImage(isSmall: false) { data, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "image-placeholder")
                }
            }
        }
    }
}
