//
//  Extensions.swift
//  Downer
//
//  Created by Joss Manger on 6/28/20.
//

import Foundation
import SwiftUI



typealias CodeRangeCouplets = Array<(String.Index,String.Index)>

//Replaces the text string with a H Stack with the wrapped indicies styled
@ViewBuilder func getHStack(str:String, couplets:CodeRangeCouplets) -> some View {
    HStack(spacing:0){
        
        //We are at the start of our line
        Text(str[str.startIndex..<str.index(before:couplets[0].0)])
        
        //For each "code couplet"
        ForEach(couplets.indices) { index in
            
            // create a text view and append the "inline code style"
            Text(str[couplets[index].0...couplets[index].1])
                .inlineCodeStyle()
            
            // look for gaps in the rest of the string, use offsets to remove the ` punctuation.
            if couplets.indices.contains(index+1), couplets[index].1 < couplets[index+1].0 {
                let lowerboundOfGap = str.index(couplets[index].1,offsetBy: 2)
                let upperBoundOfGap = str.index(before: couplets[index+1].0)
                Text(str[lowerboundOfGap..<upperBoundOfGap])
            }
            
        }
        //Finally Append a text view from the last index until the end of the string.
        Text(str[str.index(couplets.last!.1,offsetBy: 2)..<str.endIndex])
    }
}

//Inline code block style

extension Text {
    
    func inlineCodeStyle() -> some View {
        self.modifier(InlineCode())
    }
    
}

struct InlineCode: ViewModifier {
    
    func body(content:Content) -> some View {
        content.padding([.leading,.trailing],4).background(Color.secondary).foregroundColor(.white)
            .font(.system(.body, design: .monospaced)).cornerRadius(3)
    }
    
}

struct Extensions_Previews: PreviewProvider {
    
    static let str = "`\"hello, world\"` is the `main.c` program that starts Kernighan and Ritchie's C Book"
    
    static var previews: some View {
        getHStack(str: str, couplets: str.getCodeRanges())
    }
}
