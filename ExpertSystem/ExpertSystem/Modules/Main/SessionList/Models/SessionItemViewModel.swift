//
//  SessionItemViewModel.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import Foundation

struct SessionItemViewModel: Identifiable {
    let name: String
    let variantsCount: Int
    let expertsCount: Int
    let id: String

    static func from(session: Session) -> SessionItemViewModel {
        return SessionItemViewModel(name: session.name, variantsCount: session.variants.count, expertsCount: session.experts.count, id: session.id)
    }
}
