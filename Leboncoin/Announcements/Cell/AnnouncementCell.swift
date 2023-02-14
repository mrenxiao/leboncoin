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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
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

        bottomTextStackView.leadingAnchor.constraint(equalTo: topTextStackView.leadingAnchor).isActive = true
        bottomTextStackView.trailingAnchor.constraint(equalTo: topTextStackView.trailingAnchor).isActive = true
        bottomTextStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.padding).isActive = true
    }
    
    func configure(with announcement: Announcement) {
        let viewModel = AnnouncementCellViewModel(announcement: announcement)
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        categoryLabel.text = viewModel.categoryId
        creationDateLabel.text = viewModel.creationDate
        
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
