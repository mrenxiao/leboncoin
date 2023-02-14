//
//  AnnouncementCell.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import UIKit

class AnnouncementCell: UITableViewCell {

    // MARK: - Constant
    
    enum Constant {
        static let cellHeight: CGFloat = 150
        static let padding: CGFloat = 16
    }
    
    // MARK: - Outlets
    
    private let announcementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let topTextStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bottomTextStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let urgentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "exclamationmark.circle" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
     }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(announcementImageView)
        contentView.addSubview(topTextStackView)
        contentView.addSubview(bottomTextStackView)
        contentView.addSubview(urgentButton)
        topTextStackView.addArrangedSubview(titleLabel)
        topTextStackView.addArrangedSubview(priceLabel)
        bottomTextStackView.addArrangedSubview(categoryLabel)
        bottomTextStackView.addArrangedSubview(creationDateLabel)
    }
    
    private func configureConstraints() {
        announcementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.padding).isActive = true
        announcementImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.padding).isActive = true
        announcementImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.padding).isActive = true
        announcementImageView.widthAnchor.constraint(equalToConstant: Constant.cellHeight - 2 * Constant.padding).isActive = true
        
        topTextStackView.leadingAnchor.constraint(equalTo: announcementImageView.trailingAnchor, constant: Constant.padding).isActive = true
        topTextStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.padding).isActive = true
        topTextStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.padding).isActive = true

        urgentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.padding).isActive = true
        urgentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.padding).isActive = true
        urgentButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        urgentButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bottomTextStackView.leadingAnchor.constraint(equalTo: topTextStackView.leadingAnchor).isActive = true
        bottomTextStackView.trailingAnchor.constraint(equalTo: urgentButton.leadingAnchor, constant: -Constant.padding).isActive = true
        bottomTextStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.padding).isActive = true
    }
    
    func configure(with announcement: Announcement, categoriesProvider: CategoriesProvider) {
        let viewModel = AnnouncementCellViewModel(announcement: announcement, categoriesProvider: categoriesProvider)
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        categoryLabel.text = viewModel.category
        creationDateLabel.text = viewModel.creationDate
        urgentButton.isHidden = !viewModel.isUrgent
        
        viewModel.loadImage { data, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.announcementImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.announcementImageView.image = UIImage(named: "image-placeholder")
                }
            }
        }
    }
}
