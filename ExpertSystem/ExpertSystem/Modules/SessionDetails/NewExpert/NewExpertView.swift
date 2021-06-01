//
//  NewExpertView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewExpertView: View {

    let onSave: (Expert) -> ()
    @State private var name = ""
    @State private var weight = 0
    @State private var typeString = "Multi"
    @State private var lingFrom = 0
    @State private var lingTo = 100

    private let types = ["Multi", "Addi", "Ling"]

    var body: some View {
        VStack {
            TextField("name", text: $name)
            HStack {
                Text("weight: " + String(weight))
                Stepper("", value: $weight, in: 0...20, step: 1)
            }
            Picker("", selection: $typeString) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            lingSetupBlock
            Spacer()
            Button("save") {
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
            }
        }
    }

    private var lingSetupBlock: some View {
        if typeString == "Ling" {
            return VStack {
                HStack {
                    Text("from: " + String(lingFrom))
                    Stepper("", value: $lingFrom, in: 0...lingTo)
                }
                HStack {
                    Text("to: " + String(lingTo))
                    Stepper("", value: $lingTo, in: lingFrom...100)
                }
            }.toAnyView()
        }
        return EmptyView().toAnyView()
    }

}

struct NewExpertView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpertView(onSave: { _ in })
    }
}
