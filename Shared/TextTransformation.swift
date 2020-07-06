//
//  TextTransformation.swift
//  Downer
//
//  Created by Joss Manger on 7/5/20.
//

import Foundation

let validPrefixChars = Constants.validPrefixCharacters

extension String {
    
    /// Trims whitespace characters
    func trim() -> String {
        self.trimmingCharacters(in: .whitespaces)
    }
    func trimNewLines() -> String {
        self.trimmingCharacters(in: .newlines)
    }
    
    func getCodeRanges() -> Array<(String.Index,String.Index)> {
        if self.contains("`") {
            var indices = Array<(String.Index,String.Index)>()
            var current:String.Index?
            for index in self.indices{
                if self[index] == "`"{
                    if let last = current {
                        
                        //index after the first `
                        let firstCharInRange = self.index(after:last)
                        
                        //index before the last `
                        let lastCharInRange = self.index(before: index)
                        indices.append((firstCharInRange,lastCharInRange))
                        current = nil
                    } else {
                        current = index
                    }
                }
            }
            
            if indices.count > 0 {
                for couplet in indices {
                    print (self[couplet.0...couplet.1])
                }
                //apply "code styling" to that range
            }
            return indices
        }
        return []
    }
    
}
