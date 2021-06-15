//
//  NewSessionView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewSessionView: View {

    // MARL: - Environment

    @Environment(\.presentationMode) var presentationMode

    // MARK: - Properties

    let onSave: (Session) -> ()

    // MARK: - State

    @State private var text: String = ""

    // MARK: - View

    var body: some View {
        VStack {
            Spacer()
            TextField("Имя сессии", text: $text)
                .font(.title)
                .padding()
                .accentColor(.purple)
            Spacer()
            Button(action: {
                onSave(Session(name: text))
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Сохранить")
                    .foregroundColor(.purple)
                Image(systemName: "checkmark")
                    .foregroundColor(.purple)
            }
            .padding()
            .background(Color.purple.opacity(0.3))
            .cornerRadius(10)
            .padding()
        }
        .background(Color.purple.opacity(0.1))
    }

}

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView(onSave: { _ in })
    }
}
