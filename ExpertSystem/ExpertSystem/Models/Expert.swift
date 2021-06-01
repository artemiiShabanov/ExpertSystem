//
//  Expert.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 31.05.2021.
//

import Foundation

struct Expert: Hashable, Identifiable {
    private(set) var id: String = UUID().uuidString
    var type: RelationshipType
    var weight: Int
    var name: String
}

extension Expert: Codable {

}
