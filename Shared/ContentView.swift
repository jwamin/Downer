//
//  ContentView.swift
//  Shared
//
//  Created by Joss Manger on 6/25/20.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DownerDocument

    var body: some View {
      HStack{
        TextEditor(text: $document.text).frame(maxWidth:.infinity)
        WYSView(text: $document.text).frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading).padding()
      }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DownerDocument()))
    }
}
