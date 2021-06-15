//
//  NewConfidenceView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewConfidenceView: View {

    // MARK: - Environment

    @Environment(\.presentationMode) var presentationMode

    // MARK: - Properties

    let onSave: (Confidence) -> ()

    // MARK: - State

    @State private var name = ""
    @State private var index = 0

    // MARK: - View

    var body: some View {
        VStack {
            TextField("Имя", text: $name)
                .foregroundColor(.purple)
                .padding()
            HStack {
                Text("Номер: " + String(index))
                Stepper("", value: $index, in: 0...20, step: 1)
            }
            .padding()
            Spacer()
            saveButton
        }
        .background(Color.purple.opacity(0.1))
    }

    // MARK: - Subviews

    private var saveButton: some View {
        Button(action: {
            onSave(Confidence(name: name, index: index))
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Сохранить")
                .foregroundColor(.purple)
                .font(.footnote)
            Image(systemName: "checkmark")
                .foregroundColor(.purple)
                .font(.footnote)
        }
        .padding(10)
        .background(Color.purple.opacity(0.3))
        .cornerRadius(10)
        .padding(10)
    }

}

struct NewConfidenceView_Previews: PreviewProvider {
    static var previews: some View {
        NewConfidenceView(onSave: { _ in })
    }
}
