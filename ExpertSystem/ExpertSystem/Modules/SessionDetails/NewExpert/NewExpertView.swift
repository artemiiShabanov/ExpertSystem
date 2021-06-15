//
//  NewExpertView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewExpertView: View {

    // MARL: - Environment

    @Environment(\.presentationMode) var presentationMode

    // MARK: - Properties

    let onSave: (Expert) -> ()

    private let types = ["Multi", "Addi", "Ling"]

    // MARK: - State

    @State private var name = ""
    @State private var weight = 0
    @State private var typeString = "Multi"
    @State private var lingFrom = 0
    @State private var lingTo = 10

    // MARK: - View

    var body: some View {
        VStack {
            textField
            weightView
            typeView
            Spacer()
            saveButton
        }
        .background(Color.purple.opacity(0.1))
    }

    // MARK: - Subviews

    private var textField: some View {
        TextField("Имя", text: $name)
            .accentColor(.purple)
            .foregroundColor(.purple)
            .padding()
    }

    private var weightView: some View {
        HStack {
            Text("Вес: " + String(weight))
            Stepper("", value: $weight, in: 0...20, step: 1)
                .accentColor(.purple)
        }
        .padding()
    }

    private var typeView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Picker("", selection: $typeString) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .accentColor(.purple)
            .padding()
            lingSetupBlock
                .padding()
        }
    }

    private var lingSetupBlock: some View {
        if typeString == "Ling" {
            return VStack {
                HStack {
                    Text("от: " + String(lingFrom))
                    Stepper("", value: $lingFrom, in: 0...lingTo)
                }
                HStack {
                    Text("до: " + String(lingTo))
                    Stepper("", value: $lingTo, in: lingFrom...100)
                }
            }.toAnyView()
        }
        return EmptyView().toAnyView()
    }

    private var saveButton: some View {
        Button(action: {
            let type: RelationshipType
            switch typeString {
            case "Multi":
                type = .multi
            case "Addi":
                type = .addi
            case "Ling":
                type = .ling(min: lingFrom, max: lingTo)
            default:
                type = .multi
            }
            onSave(Expert(type: type, weight: weight, name: name))
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

struct NewExpertView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpertView(onSave: { _ in })
    }
}
