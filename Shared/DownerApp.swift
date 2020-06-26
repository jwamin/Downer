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
            ContentView(document: file.$document)
        }
    }
}
