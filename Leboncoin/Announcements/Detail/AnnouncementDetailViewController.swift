//
//  AnnouncementDetailViewController.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 14/02/2023.
//

import Foundation
import UIKit

class UrgentView: UIView {
    
    enum Constant {
        static let imageWidth: CGFloat = 20
        static let padding: CGFloat = 8
    }
    
    private lazy var urgentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.circle")
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var urgentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Cette annonce est urgente"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(urgentImageView)
        addSubview(urgentLabel)
        
        urgentImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        urgentImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        urgentImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        urgentImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth).isActive = true
        urgentImageView.heightAnchor.constraint(equalToConstant: Constant.imageWidth).isActive = true
        
        urgentLabel.leadingAnchor.constraint(equalTo: urgentImageView.trailingAnchor, constant: Constant.padding).isActive = true
        urgentLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        urgentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

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
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creationDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var urgentView: UrgentView = {
        let view = UrgentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
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
        configureConstraints()
        updateUI()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(priceLabel)
        verticalStackView.addArrangedSubview(categoryLabel)
        verticalStackView.addArrangedSubview(creationDateLabel)
        verticalStackView.addArrangedSubview(urgentView)
        verticalStackView.addArrangedSubview(separatorView)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureConstraints() {
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
    
    private func updateUI() {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        categoryLabel.text = viewModel.category
        creationDateLabel.text = viewModel.creationDate
        descriptionLabel.text = viewModel.description
        urgentView.isHidden = !viewModel.isUrgent

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
