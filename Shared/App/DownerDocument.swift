//
//  DownerDocument.swift
//  Shared
//
//  Created by Joss Manger on 6/25/20.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var markdownDoc: UTType {
        UTType(importedAs: "com.jossy.markdown")
    }
}

struct DownerDocument: FileDocument {
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.markdownDoc] }

    init(fileWrapper: FileWrapper, contentType: UTType) throws {
        guard let data = fileWrapper.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
        let data = text.data(using: .utf8)!
        fileWrapper = FileWrapper(regularFileWithContents: data)
    }
}
