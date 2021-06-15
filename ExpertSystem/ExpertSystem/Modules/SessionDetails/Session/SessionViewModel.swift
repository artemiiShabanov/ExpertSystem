//
//  SessionViewModel.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

protocol SessionViewModelProtocol: ObservableObject {
    var session: Session { get }
    var isLoading: Bool { get }
    var name: String { get }
    var experts: [Expert] { get }
    var variants: [Variant] { get }
    var confidences: [Confidence] { get }
    var result: [Float] { get }
    func add(expert: Expert)
    func delete(expert: Expert)
    func add(variant: Variant)
    func delete(variant: Variant)
    func add(confidence: Confidence)
    func delete(confidence: Confidence)
    func updateUI()
    func calculate()
}

class MockSessionViewModel: SessionViewModelProtocol {
    var session = Session(name: "Сессия 1")
    @Published var isLoading: Bool = false
    @Published var name: String = "Сессия 1"
    @Published var experts: [Expert] = [
        Expert(type: .addi, weight: 0, name: "Эксперт 1"),
        Expert(type: .addi, weight: 1, name: "Эксперт 2"),
        Expert(type: .ling(min: 0, max: 10), weight: 2, name: "Эксперт 3"),
        Expert(type: .multi, weight: 3, name: "Эксперт 4")
    ]
    @Published var variants: [Variant] = [
        Variant(index: 1, name: "Вариант 1"),
        Variant(index: 2, name: "Вариант 2"),
        Variant(index: 3, name: "Вариант 3")
    ]
    @Published var confidences: [Confidence] = [
        Confidence(name: "Не верен", index: 0),
        Confidence(name: "Средне уверен", index: 1),
        Confidence(name: "Абсолютно уверен", index: 2)
    ]
    @Published var result: [Float] = []

    func add(expert: Expert) {

    }
    func delete(expert: Expert) {

    }
    func add(variant: Variant) {

    }
    func delete(variant: Variant) {

    }
    func add(confidence: Confidence) {

    }
    func delete(confidence: Confidence) {

    }
    func updateUI(){

    }
    func calculate() {
        result = [0.2, 0.3, 0.1, 0.4]
    }
}

class SessionViewModel: SessionViewModelProtocol {

    // MARK: - Properties

    private(set) var session: Session

    // MARK: - Init

    init(session: Session) {
        self.session = session
    }

    // MARK: - Publishes

    @Published var isLoading = false
    @Published var name: String = ""
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
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
        }
    }


}
