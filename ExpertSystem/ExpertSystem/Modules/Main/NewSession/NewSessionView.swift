//
//  NewSessionView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewSessionView: View {

    let onSave: (Session) -> ()
    @State private var text: String = ""

    var body: some View {
        VStack {
            TextField("name", text: $text)
            Spacer()
            Button("save") {
                onSave(Session(name: text))
            }
        }
    }

}

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView(onSave: { _ in })
    }
}
