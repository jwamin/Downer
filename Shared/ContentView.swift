//
//  ContentView.swift
//  Shared
//
//  Created by Joss Manger on 6/25/20.
//

import SwiftUI

struct ContentView: View {
  @Binding var document: DownerDocument
  
  #if os(iOS)
  @Environment(\.horizontalSizeClass) var horizontalClass
  
  func getEditor<Content:View>(@ViewBuilder content: @escaping () -> Content) -> AnyView {
    if horizontalClass == .compact {
      return AnyView(VStack {
        content()
      })
    } else {
      return AnyView(HStack {
        content()
      })
    }
  }
  #endif
  
    var body: some View {
      #if os(iOS)
      return getEditor(){
        TextEditor(text: $document.text).frame(maxWidth:.infinity)
        WYSView(text: $document.text).frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading).padding()
      }
      #endif
      #if os(macOS)
      return HStack{
        TextEditor(text: $document.text).frame(maxWidth:.infinity)
        WYSView(text: $document.text).frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading).padding()
      }
      #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DownerDocument()))
    }
}
