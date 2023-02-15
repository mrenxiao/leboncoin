//
//  UrgentView.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 15/02/2023.
//

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
        label.text = "label.urgent".localized
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
