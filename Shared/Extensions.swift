//
//  Extensions.swift
//  Downer
//
//  Created by Joss Manger on 6/28/20.
//

import Foundation
import SwiftUI

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
                        indices.append((last, index))
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

typealias CodeRangeCouplets = Array<(String.Index,String.Index)>

func getHStack(str:String, indices:CodeRangeCouplets) -> AnyView {
    AnyView(
        HStack(spacing:0){
        Text(str[str.startIndex..<indices[0].0])
        ForEach(indices.indices) { index in
            Text(str[indices[index].0...indices[index].1])
                .background(Color.secondary).foregroundColor(.white)
                .font(.system(.body, design: .monospaced)).cornerRadius(3).padding(1)
            if indices.indices.contains(index+1), indices[index].1 < indices[index+1].0 {
                let lowerboundOfGap = str.index(after: indices[index].1)
                let upperBoundOfGap = str.index(before: indices[index+1].0)
                Text(str[lowerboundOfGap...upperBoundOfGap])
            }
        }
        Text(str[indices.last!.1..<str.endIndex])
    })
}
