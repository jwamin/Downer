//
//  WYSView.swift
//  Downer
//
//  Created by Joss Manger on 6/26/20.
//

import SwiftUI

var validChars = "#*`[]()"

struct WYSView: View {
  @Binding var text: String
  
  func processString(str: String) -> some View {
    let components = str.components(separatedBy: "\n")
    
    return VStack(alignment:.leading){
      ForEach(components,id:\.self){ str in
        getViewForComponent(str: str)
      }
    }
      
  }
  
  func getViewForComponent(str: String) -> Text {
    
    //from first character to alphanumeric
    var startString = str.trimmingCharacters(in: .whitespaces)
    var prefix = ""
    for index in str.indices {
      let indexChar = str[index]
      if indexChar == " " {
        continue
      }
      if validChars.contains(indexChar) {
        prefix.append(indexChar)
      } else {
        break
      }
    }
    
    let displayString = startString.dropFirst(prefix.count)
    
    switch prefix {
    case "#":
      return Text(displayString).font(.largeTitle)
    case "##":
      return Text(displayString).font(.title)
    case "###":
      return Text(displayString).font(.headline)
    case "####":
      return Text(displayString).font(.subheadline)
    case "*":
      return Text("● "+displayString).font(.system(.body))
    default:
      return Text(str)
    }
    
  }
  
    var body: some View {
        processString(str: text)
    }
}

struct WYSView_Previews: PreviewProvider {
    static var previews: some View {
      
let str = """
#Hello
##World
###world?
####Whatever
*Hello world
"""
      
      return WYSView(text: .constant(str))
    }
}
