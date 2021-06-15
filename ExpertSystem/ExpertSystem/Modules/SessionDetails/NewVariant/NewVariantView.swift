//
//  NewVariantView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewVariantView: View {

    // MARK: - Environment

    @Environment(\.presentationMode) var presentationMode

    // MARK: - Properties

    let onSave: (Variant) -> ()
    let index: Int

    // MARK: - State

    @State private var name = ""

    // MARK: - View

    var body: some View {
        VStack {
            Text("Вариант №" + String(index))
                .foregroundColor(.purple)
                .padding()
            TextField("Имя", text: $name)
                .padding()
            Spacer()
            saveButton
        }
        .background(Color.purple.opacity(0.1))

    }

    // MARK: - Subviews


    private var saveButton: some View {
        Button(action: {
            onSave(Variant(index: index, name: name))
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

struct NewVariantView_Previews: PreviewProvider {
    static var previews: some View {
        NewVariantView(onSave: { _ in }, index: 3)
    }
}
