//
//  WYSView.swift
//  Downer
//
//  Created by Joss Manger on 6/26/20.
//

import SwiftUI

var validPrefixChars = "#*[]()!"

struct WYSView: View {
  @Binding var text: String
  
  func processString(str: String) -> some View {
    let components = str.components(separatedBy: "\n")
    //work out how many string there are, and group them, in order to prepare for swiftui's view numebr overflow?
    
    return VStack(alignment:.leading){
      ForEach(components,id:\.self){ str in
        getViewForComponent(str: str)
      }
    }
      
  }
    
  func getViewForComponent(str: String) -> AnyView {
    
    //from first character to alphanumeric
    let startString = str.trim()
    var prefix = ""
    for index in str.indices {
      let indexChar = str[index]
      if indexChar == " " {
        break
      }
      if validPrefixChars.contains(indexChar) {
        prefix.append(indexChar)
      } else {
        break
      }
    }
    
    let displayString = String(startString.dropFirst(prefix.count)).trim()

    let codeRanges = displayString.getCodeRanges()
    
    
    if codeRanges.count > 0{
        return AnyView(getHStack(str: displayString, indices: codeRanges))
    }
    
    switch prefix {
    case "#":
        return AnyView(Text(displayString).font(.largeTitle).bold())
    case "##":
      return AnyView(Text(displayString).font(.title))
    case "###":
      return AnyView(Text(displayString).font(.headline))
    case "####":
      return AnyView(Text(displayString).font(.subheadline))
    case "*":
      return AnyView(Text("● "+displayString).font(.system(.body)))
    
    default:
        return AnyView(Text(str).font(.system(.body)))
    }
    
  }
  
    var body: some View {
        ScrollView{
            processString(str: text)
        }.frame(maxWidth:.infinity,alignment: .leading)
    }
}

struct WYSView_Previews: PreviewProvider {
    static var previews: some View {
      
let str = """
#Hello
##World
###world? ####Whatever
*Hello world
so `how about` this? `right`?
"""
      
      return WYSView(text: .constant(str))
    }
}
