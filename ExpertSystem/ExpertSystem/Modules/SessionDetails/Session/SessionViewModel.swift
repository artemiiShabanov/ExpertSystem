//
//  SessionViewModel.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

class SessionViewModel: ObservableObject {

    // MARK: - Properties

    private(set) var session: Session

    // MARK: - Init

    init(session: Session) {
        self.session = session
    }

    // MARK: - Publishes

    @Published var isLoading = false
    @Published var name: String?
    @Published var experts: [Expert] = []
    @Published var variants: [Variant] = []
    @Published var confidences: [Confidence] = []
    @Published var result: [Float] = []

    // MARK: - API

    func add(expert: Expert) {
        session.experts.append(expert)
        updateUI()
    }

    func delete(expert: Expert) {
        if let index = session.experts.firstIndex(of: expert) {
            session.experts.remove(at: index)
            updateUI()
        }
    }

    func add(variant: Variant) {
        session.variants.append(variant)
        updateUI()
    }

    func delete(variant: Variant) {
        if let index = session.variants.firstIndex(of: variant) {
            session.variants.remove(at: index)
            updateUI()
        }
    }

    func add(confidence: Confidence) {
        session.confidences.append(confidence)
        updateUI()
    }

    func delete(confidence: Confidence) {
        if let index = session.confidences.firstIndex(of: confidence) {
            session.confidences.remove(at: index)
            updateUI()
        }
    }

    func updateUI() {
        name = session.name
        experts = session.experts
        variants = session.variants
        confidences = session.confidences
        result = session.result
    }

    func calculate() {
        isLoading = true
        session.calculate {
            DispatchQueue.main.async {  [weak self] in
                self?.isLoading = false
            }
        }
    }


}
