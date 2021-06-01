//
//  Confidence.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 31.05.2021.
//

import Foundation

struct Confidence: Identifiable, Equatable {
    private(set) var id = UUID().uuidString
    var name: String
    var index: Int
}

extension Confidence: Codable { }
