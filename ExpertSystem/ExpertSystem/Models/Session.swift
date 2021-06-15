//
//  Session.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 31.05.2021.
//

import Foundation

struct Mark: Codable {
    let confidence: Confidence
    let value: String
}

typealias Marks = [VariantPair: Mark]
typealias Preferences = [Expert: Marks]

struct Session: Identifiable {
    let id: String
    let name: String

    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }

    var experts: [Expert] = [] {
        didSet {
            reset()
        }
    }
    var variants: [Variant] = [] {
        didSet {
            reset()
        }
    }
    var confidences: [Confidence] = [] {
        didSet {
            reset()
        }
    }

    private(set) var variantPairs: [VariantPair] = []
    var preferences: Preferences = [:]

    var result: [Float] = [] // sum == 1, count == variant.count

    mutating func updateConfidences(confidences: [Confidence]) {
        self.confidences = confidences
        reset()
    }

    mutating func reset() {
        variantPairs = []
        preferences = [:]
        result = []
    }

    func calculate(completion: @escaping () -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion()
        }
    }

}



extension Session: Codable {
    
}
