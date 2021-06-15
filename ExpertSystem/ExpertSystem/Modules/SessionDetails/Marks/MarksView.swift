//
//  MarksView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 02.06.2021.
//

import SwiftUI

struct MarksView: View {

    // MARK: - Properties

    let expert: Expert
    var variantPairs: [VariantPair]
    var onSave: ((Marks) -> (Void))? = nil

    // MARK: - View

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MarksView_Previews: PreviewProvider {
    static var previews: some View {
        MarksView(expert: .init(id: "", type: .addi, weight: 0, name: ""), variantPairs: [])
    }
}
