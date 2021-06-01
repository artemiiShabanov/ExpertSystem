//
//  SessionListView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct SessionListView: View {

    // MARK: - Models

    @StateObject var vm = SessionListViewModel()

    // MARK: - View

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Header()
                    ForEach(vm.sessionModels) {
                        SessionItemView(session: $0)
                    }
                }
            }
            VStack {
                Spacer()
                Footer()
            }
        }
        .onAppear {
            vm.loadFromDisk()
        }
    }
}

// MARK: - Subviews

fileprivate struct Header: View {

    // MARK: - View

    var body: some View {
        Text("Some header")
            .frame(height: 100)
            .frame(maxWidth: .infinity)
    }

}

fileprivate struct SessionItemView: View {

    // MARK: - Models

    let session: SessionItemViewModel

    // MARK: - View

    var body: some View {
        Color.red
            .frame(height: 100)
            .frame(maxWidth: .infinity)
    }
}

fileprivate struct Footer: View {

    // MARK: - View

    var body: some View {
        Button("New session") {

        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .padding()
    }
}

// MARK: - Previews

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewLayout(.sizeThatFits)
    }
}

struct SessionItemView_Previews: PreviewProvider {
    static var previews: some View {
        SessionItemView(session: SessionItemViewModel(name: "Some name", variantsCount: 4, expertsCount: 3, id: "fd"))
            .previewLayout(.sizeThatFits)
    }
}

struct SessionListView_Previews: PreviewProvider {
    static var previews: some View {
        SessionListView()
    }
}
