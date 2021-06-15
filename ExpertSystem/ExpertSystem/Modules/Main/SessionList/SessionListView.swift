//
//  SessionListView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct SessionListView<VM: SessionListViewModelProtocol>: View {

    // MARK: - State

    @StateObject private var vm: VM
    @State private var shownNewSession = false
    @State private var session: Session?

    // MARK: - Init

    init(vm: VM) {
        _vm = StateObject(wrappedValue: vm)
    }

    // MARK: - View

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    header
                    ForEach(vm.sessionModels) {
                        SessionItemView(session: $0,
                                        onTap: {
                                            self.session = vm.getSession(by: $0)
                                        },
                                        onDelete: {
                                            vm.deleteSession(by: $0)
                                        })
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                    }
                    Spacer(minLength: 100)
                }
            }
            VStack {
                Spacer()
                footer
            }
        }
        .onAppear {
            vm.loadFromDisk()
        }
        .sheet(isPresented: $shownNewSession, content: {
            NewSessionView(onSave: {
                vm.add(session: $0)
            })
        })
        .sheet(item: $session, content: {
            SessionView(vm: SessionViewModel(session: $0), onSave: {
                self.vm.update(session: $0)
            })
        })
    }

    // MARK: - Subviews

    private var header: some View {
        HStack {
            Text("Текущие сессии")
                .font(.title)
                .padding()
            Spacer()
        }
    }

    private var footer: some View {
        Button(action: {
            shownNewSession = true
        }, label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)
            }
            .background(Color.white)
            .cornerRadius(25)
        })
        .padding()
    }
    
}

fileprivate struct SessionItemView: View {

    // MARK: - Models

    let session: SessionItemViewModel
    let onTap: (String) -> ()
    let onDelete: (String) -> ()

    // MARK: - View

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(session.name)
                    .font(.headline)
                    .padding(.bottom)
                HStack {
                    HStack(spacing: 0) {
                        Text("Экспертов: ")
                            .font(.caption2)
                        Text(String(session.expertsCount))
                            .font(.caption2)
                    }
                    HStack(spacing: 0) {
                        Text("Вариантов: ")
                            .font(.caption2)
                        Text(String(session.variantsCount))
                            .font(.caption2)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.purple.opacity(0.2))
        .cornerRadius(5)
        .onTapGesture {
            onTap(session.id)
        }
        .contextMenu {
            Button(action: {
                onTap(session.id)
            }) {
                Text("Open")
            }

            Button(action: {
                onDelete(session.id)
            }) {
                Text("Delete")
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
            }
        }
    }
}

// MARK: - Previews

struct SessionListView_Previews: PreviewProvider {
    static var previews: some View {
        SessionListView(vm: MockSessionListViewModel())
    }
}
