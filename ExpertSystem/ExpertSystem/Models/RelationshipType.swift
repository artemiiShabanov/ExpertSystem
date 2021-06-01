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

extension RelationshipType: Codable {

    enum Key: CodingKey {
        case rawValue
    }

    enum CodingError: Error {
        case unknownValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        if rawValue == "multi" {
            self = .multi
        }
        if rawValue == "addi" {
            self = .addi
        }
        if rawValue.starts(with: "ling") {
            guard let firstIndex = rawValue.firstIndex(where: { $0 == "-" }) else { throw CodingError.unknownValue }
            guard let secondIndex = rawValue.suffix(from: firstIndex).firstIndex(where: { $0 == "-" }) else { throw CodingError.unknownValue }
            let min = Int(rawValue[rawValue.index(after: firstIndex) ..< secondIndex]) ?? 0
            let max = Int(rawValue[rawValue.index(after: secondIndex) ..< rawValue.endIndex]) ?? 10
            self = .ling(min: min, max: max)
        }
        throw CodingError.unknownValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .multi:
            try container.encode("multi", forKey: .rawValue)
        case .addi:
            try container.encode("addi", forKey: .rawValue)
        case .ling(let min, let max):
            try container.encode("ling-\(min)-\(max)", forKey: .rawValue)
        }
    }

}
