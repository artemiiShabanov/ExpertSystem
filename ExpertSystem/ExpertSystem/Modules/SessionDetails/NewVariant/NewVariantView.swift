//
//  NewVariantView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct NewVariantView: View {

    let onSave: (Variant) -> ()
    let index: Int
    @State private var name = ""

    var body: some View {
        VStack {
            Text("variant number " + String(index))
            TextField("name", text: $name)
            Spacer()
            Button("save") {
                onSave(Variant(index: index, name: name))
            }
        }
    }

}

struct NewVariantView_Previews: PreviewProvider {
    static var previews: some View {
        NewVariantView(onSave: { _ in }, index: 3)
    }
}
