//
//  SessionListViewModel.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

class SessionListViewModel: ObservableObject {

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
    }

    func deleteSession(by id: String) {
        if let index = sessions.firstIndex(where: { $0.id == id }) {
            sessions.remove(at: index)
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
