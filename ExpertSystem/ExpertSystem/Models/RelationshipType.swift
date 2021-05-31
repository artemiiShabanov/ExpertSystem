//
//  RelationshipType.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 31.05.2021.
//

import Foundation

enum RelationshipType: Hashable {
    case multi
    case addi
    case ling(min: Int, max: Int)

    var name: String {
        switch self {
        case .multi:
            return "Мультипликативное"
        case .addi:
            return "Аддитивное"
        case .ling(_, _):
            return "Лингвистическое двухкортежное"
        }
    }
}

enum MultiPossibleValue {
    case a1_9
    case a1_8
    case a1_7
    case a1_6
    case a1_5
    case a1_4
    case a1_3
    case a1_2
    case a1
    case a2
    case a3
    case a4
    case a5
    case a6
    case a7
    case a8
    case a9
}
