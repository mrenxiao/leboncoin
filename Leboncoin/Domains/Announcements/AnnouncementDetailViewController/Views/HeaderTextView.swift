//
//  HeaderTextView.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 15/02/2023.
//

import UIKit

class HeaderTextView: UIView {
    
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
    
    private lazy var urgentView: UrgentView = {
        let view = UrgentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var viewModel: AnnouncementViewModel! {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(priceLabel)
        verticalStackView.addArrangedSubview(categoryLabel)
        verticalStackView.addArrangedSubview(creationDateLabel)
        verticalStackView.addArrangedSubview(urgentView)
        
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func updateUI() {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        categoryLabel.text = viewModel.category
        creationDateLabel.text = viewModel.creationDate
        urgentView.isHidden = !viewModel.isUrgent
    }
}
