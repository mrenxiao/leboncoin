//
//  String+Utils.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 15/02/2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
