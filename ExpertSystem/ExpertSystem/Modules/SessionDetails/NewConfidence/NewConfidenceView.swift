//
//  NewConfidenceView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewConfidenceView: View {

    let onSave: (Confidence) -> ()
    @State private var name = ""
    @State private var index = 0

    var body: some View {
        VStack {
            TextField("name", text: $name)
            HStack {
                Text("index: " + String(index))
                Stepper("", value: $index, in: 0...20, step: 1)
            }
            Spacer()
            Button("save") {
                onSave(Confidence(name: name, index: index))
            }
        }
    }

}

struct NewConfidenceView_Previews: PreviewProvider {
    static var previews: some View {
        NewConfidenceView(onSave: { _ in })
    }
}
