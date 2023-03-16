//
//  WhatTheErrorCodeInputView.swift
//  
//
//  Created by Antoine van der Lee on 16/03/2023.
//

import SwiftUI

public struct WhatTheErrorCodeInputView: View {
    @State var input: String = ""
    @State var result: [CocoaErrorDescription] = []

    public init() { }

    public var body: some View {
        VStack {
            header
            results
        }.navigationTitle("What The Error Code?")
    }

    private var header: some View {
        VStack {
            Text("Fill in an error description to clarify the code.")
                .font(.headline)
            Text("Example input: Domain=NSCocoaErrorDomain Code=1590 \"The operation couldn't be completed. (Cocoa error 1590.)")
                .italic()
                .padding(.bottom)
            HStack {
                TextField("Enter code description", text: $input) {
                    updateResult()
                }
                Button("Clarify") {
                    updateResult()
                }
            }
        }.padding(.horizontal, 20)
            .padding()
    }

    private var results: some View {
        Table(result) {
            TableColumn("Code") { error in
                Text(String(error.code))
            }.width(50)

            TableColumn("Key", value: \.key)
                .width(340)

            TableColumn("Description") { error in
                Text(error.description.localizedCapitalized)
            }
        }
    }

    private func updateResult() {
        result = WhatTheErrorCode.description(for: input)
    }
}
