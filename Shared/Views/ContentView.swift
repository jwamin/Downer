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
    
    func insertAtBeginningOfLine(_ str:String){
        print("will prepend \(str) to line")
    }
    private let touchBarStrings = ["#","##","###","*"]
    
    var body: some View {
        
        #if os(iOS)
        return getEditor(){
            TextEditor(text: $document.text).frame(maxWidth:.infinity)
            WYSView(text: $document.text).frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
        }
        #endif
        
        #if os(macOS)
        
        let touchBar = TouchBar(id:"mac") {
            ForEach(self.touchBarStrings,id:\.self){ str in
                Button(action: {
                    self.insertAtBeginningOfLine(str)
                }, label: {
                    Text(str).frame(minWidth: 88)
                })
            }
        }
        
        return HStack{
            TextEditor(text: $document.text).frame(maxWidth:.infinity).touchBar(touchBar)
            WYSView(text: $document.text).frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
        }
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DownerDocument()))
    }
}
