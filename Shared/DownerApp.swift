//
//  DownerApp.swift
//  Shared
//
//  Created by Joss Manger on 6/25/20.
//

import SwiftUI

@main
struct DownerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DownerDocument()) { file in
            #if os(macOS)
            ContentView(document: file.$document)
                .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem {
                        Button("Button", action: {
                            print("something")
                        })
                    }
                }// MacOS only
            #else
            ContentView(document: file.$document)
            #endif
        }
    }
}
