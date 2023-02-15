//
//  SiretView.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 15/02/2023.
//

import UIKit

class SiretView: UIView {
    
    private lazy var proLabel: PaddingLabel = {
        let label = PaddingLabel(withInsets: 2, 2, 8, 8)
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 4
        label.text = "Pro"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var siretLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var siret = "" {
        didSet {
            updateSiretLabel()
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
        addSubview(proLabel)
        addSubview(siretLabel)
        
        proLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        proLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        proLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        siretLabel.leadingAnchor.constraint(equalTo: proLabel.trailingAnchor, constant: 8).isActive = true
        siretLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        siretLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func updateSiretLabel() {
        siretLabel.text = "Nº SIRET : " + siret
    }
}
