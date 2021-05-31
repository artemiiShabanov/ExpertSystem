//
//  Session.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 31.05.2021.
//

import Foundation

struct Mark {
    let confidence: Confidence
    let value: String
}

struct Session {
    private(set) var experts: [Expert] = []
    private(set) var variants: [Variant] = []
    private(set) var confidences: [Confidence] = []

    private(set) var variantPairs: [VariantPair] = []
    private(set) var preferences: [Expert: [VariantPair: Mark]]

    var result: [Float] = [] // sum == 1, count == variant.count

    mutating func updateExperts(experts: [Expert]) {
        self.experts = experts
        reset()
    }

    mutating func updateVariants(variants: [Variant]) {
        self.variants = variants
        reset()
    }

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
