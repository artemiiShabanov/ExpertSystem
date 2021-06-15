//
//  SessionListViewModel.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

protocol SessionListViewModelProtocol: ObservableObject {
    var sessionModels: [SessionItemViewModel] { get }
    func loadFromDisk()
    func add(session: Session)
    func update(session: Session)
    func deleteSession(by id: String)
    func getSession(by id: String) -> Session?
}

class MockSessionListViewModel: SessionListViewModelProtocol {

    @Published var sessionModels: [SessionItemViewModel] = []

    func loadFromDisk() {
        sessionModels.append(contentsOf: [
                                SessionItemViewModel(name: "Сессия 1", variantsCount: 4, expertsCount: 3, id: "1"),
                                SessionItemViewModel(name: "Сессия 2", variantsCount: 5, expertsCount: 7, id: "2"),
                                SessionItemViewModel(name: "Сессия 3", variantsCount: 3, expertsCount: 5, id: "3"),
                                SessionItemViewModel(name: "Сессия 4", variantsCount: 3, expertsCount: 2, id: "4")
        ])
    }
    func update(session: Session) {
        guard let index = sessionModels.firstIndex(where: { $0.id == session.id } ) else {
            return
        }
        sessionModels[index] = SessionItemViewModel.from(session: session)
    }
    func add(session: Session) {
        sessionModels.append(SessionItemViewModel.from(session: session))
    }
    func deleteSession(by id: String) {
        if let index = sessionModels.firstIndex(where: { $0.id == id }) {
            sessionModels.remove(at: index)
        }
    }
    func getSession(by id: String) -> Session? {
        return nil
    }
}

class SessionListViewModel: SessionListViewModelProtocol {

    // MARK: - Private Properties

    private let udKey = "Sessions"
    private var sessions: [Session] = [] {
        didSet {
            sessionModels = sessions.map { SessionItemViewModel.from(session: $0) }
        }
    }

    // MARK: - Published

    @Published var sessionModels: [SessionItemViewModel] = []

    // MARK: - API

    func loadFromDisk() {
        let ud = UserDefaults.standard
        if let data = ud.object(forKey: udKey) as? Data {
            let decoder = JSONDecoder()
            if let sessions = try? decoder.decode([Session].self, from: data) {
                self.sessions = sessions
            }
        }
    }

    func add(session: Session) {
        sessions.append(session)
        updateUD()
    }

    func update(session: Session) {
        guard let index = sessions.firstIndex(where: { $0.id == session.id } ) else {
            return
        }
        sessions[index] = session
        updateUD()
    }

    func deleteSession(by id: String) {
        if let index = sessions.firstIndex(where: { $0.id == id }) {
            sessions.remove(at: index)
            updateUD()
        }
    }

    func getSession(by id: String) -> Session? {
        return sessions.first(where: { $0.id == id })
    }

    // MARK: - Private

    private func updateUD() {
        let ud = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(sessions) {
            ud.set(encoded, forKey: udKey)
        }
    }

}
