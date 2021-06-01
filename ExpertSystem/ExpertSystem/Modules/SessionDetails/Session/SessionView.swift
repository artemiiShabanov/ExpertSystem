//
//  SessionView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct SessionView: View {

    // MARK: - Properties

    let vm: SessionViewModel

    // MARK: - View

    var body: some View {
        VStack {
            Header()
            ScrollView(showsIndicators: false) {
                expertsBlock
                Spacer(minLength: 15)
                variantsBlock
                Spacer(minLength: 15)
                confidencesBlock
            }
            SaveButton()
            CalculateButton()
        }
    }

    // MARK: - Subviews

    private var expertsBlock: some View {
        VStack {
            Subtitle(name: "Experts")
            ForEach(vm.experts) {
                ExpertItemView(expert: $0)
            }
            AddButton(name: "Expert")
        }
    }

    private var variantsBlock: some View {
        VStack {
            Subtitle(name: "Variants")
            ForEach(vm.variants) {
                VariantItemView(variant: $0)
            }
            AddButton(name: "Variant")
        }
    }

    private var confidencesBlock: some View {
        VStack {
            Subtitle(name: "Confidences")
            ForEach(vm.confidences) {
                ConfidenceItemView(confidence: $0)
            }
            AddButton(name: "Confidence")
        }
    }

}

// MARK: - Subviews

fileprivate struct Header: View {

    // MARK: - View

    var body: some View {
        Text("Header")
            .foregroundColor(.gray)
    }
}

fileprivate struct Subtitle: View {

    // MARK: - Properties

    let name: String

    // MARK: - View

    var body: some View {
        Text(name)
            .foregroundColor(.red)
    }
}

fileprivate struct AddButton: View {

    // MARK: - Properties

    let name: String

    // MARK: - View

    var body: some View {
        Button("Add " + name) {

        }
        .foregroundColor(.green)
    }
}

fileprivate struct SaveButton: View {

    // MARK: - View

    var body: some View {
        Button("Save") {

        }
        .foregroundColor(.orange)
    }
}

fileprivate struct CalculateButton: View {

    // MARK: - View

    var body: some View {
        Button("Calculate") {

        }
        .foregroundColor(.purple)
    }
}

fileprivate struct ExpertItemView: View {

    // MARK: - Properties

    let expert: Expert

    // MARK: - View

    var body: some View {
        Text(expert.name)
    }
}

fileprivate struct VariantItemView: View {

    // MARK: - Properties

    let variant: Variant

    // MARK: - View

    var body: some View {
        Text(variant.name)
    }
}

fileprivate struct ConfidenceItemView: View {

    // MARK: - Properties

    let confidence: Confidence

    // MARK: - View

    var body: some View {
        Text(confidence.name)
    }
}

// MARK: - Previews

struct SessionView_Previews: PreviewProvider {

    static var previews: some View {
        SessionView(vm: SessionViewModel(session: .init(name: "some name")))
    }
}
