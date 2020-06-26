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
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DownerDocument()))
    }
}
