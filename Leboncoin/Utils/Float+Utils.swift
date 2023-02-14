//
//  Float+Utils.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 14/02/2023.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
