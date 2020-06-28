//
//  Extensions.swift
//  Downer
//
//  Created by Joss Manger on 6/28/20.
//

import Foundation

extension String {
    
    
    /// Trims whitespace characters
    func trim() -> String {
        self.trimmingCharacters(in: .whitespaces)
    }
    
}
