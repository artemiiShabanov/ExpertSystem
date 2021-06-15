//
//  SessionView.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 01.06.2021.
//

import SwiftUI

struct SessionView<VM: SessionViewModelProtocol>: View {

    // MARK: - Properties

    var onSave: (Session) -> ()

    // MARK: - State

    @StateObject var vm: VM
    @State private var openNewExpert = false
    @State private var openNewVariant = false
    @State private var openNewConfidence = false

    // MARK: - Init

    init(vm: VM, onSave: @escaping (Session) -> ()) {
        self._vm = StateObject(wrappedValue: vm)
        self.onSave = onSave
    }

    // MARK: - View

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView(showsIndicators: false) {
                Spacer(minLength: 15)
                expertsBlock
                Spacer(minLength: 15)
                variantsBlock
                Spacer(minLength: 15)
                confidencesBlock
            }
        }
        .sheet(isPresented: $openNewExpert, content: {
            NewExpertView(onSave: { expert in
                vm.add(expert: expert)
            })
        })
        .sheet(isPresented: $openNewVariant, content: {
            NewVariantView(onSave: { variant in
                vm.add(variant: variant)
            }, index: vm.variants.count)
        })
        .sheet(isPresented: $openNewConfidence, content: {
            NewConfidenceView(onSave: { confidence in
                vm.add(confidence: confidence)
            })
        })
    }

    // MARK: - Subviews

    private var expertsBlock: some View {
        VStack {
            Subtitle(name: "Эксперты")
            ForEach(vm.experts) {
                ExpertItemView(expert: $0, onTap: { _ in

                }, onDelete: {
                    vm.delete(expert: $0)
                })
                .padding(5)
            }
            AddButton(name: "эксперта", onAdd: { openNewExpert = true })
            Rectangle().foregroundColor(.purple).frame(height: 3)
        }
    }

    private var variantsBlock: some View {
        VStack {
            Subtitle(name: "Варианты")
            ForEach(vm.variants) {
                VariantItemView(variant: $0, onDelete: {
                    vm.delete(variant: $0)
                })
                .padding(5)
            }
            AddButton(name: "вариант", onAdd: { openNewVariant = true })
            Rectangle().foregroundColor(.purple).frame(height: 3)
        }
    }

    private var confidencesBlock: some View {
        VStack {
            Subtitle(name: "Уверенности")
            ForEach(vm.confidences) {
                ConfidenceItemView(confidence: $0, onDelete: {
                    vm.delete(confidence: $0)
                })
                .padding(5)
            }
            AddButton(name: "уверенность", onAdd: { openNewConfidence = true })
            Rectangle().foregroundColor(.purple).frame(height: 3)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(vm.name)
                    .font(.title)
                    .foregroundColor(.purple)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text("вектор результата:")
                    .font(.caption)
                    .foregroundColor(.gray)
                vm.result.isEmpty
                    ? Text("пока не рассчитан").font(.caption)
                    : Text("( " + vm.result.map {
                        String($0)
                    }.joined(separator:" - ") + " )")
                    .font(.caption)
                    .foregroundColor(.purple)
            }
            .padding(.horizontal)
            .padding(.bottom)
            HStack {
                saveButton
                Spacer()
                calculateButton
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.purple.opacity(0.1))
    }

    private var saveButton: some View {
        Button(action: {
            onSave(vm.session)
        }) {
            Text("Сохранить")
                .foregroundColor(.purple)
                .font(.footnote)
            Image(systemName: "checkmark")
                .foregroundColor(.purple)
                .font(.footnote)
        }
        .padding(10)
        .background(Color.purple.opacity(0.3))
        .cornerRadius(10)
    }

    private var calculateButton: some View {
        Button(action: {
            vm.calculate()
        }) {
            Text("Рассчитать")
                .foregroundColor(.purple)
                .font(.footnote)
            Image(systemName: "function")
                .foregroundColor(.purple)
                .font(.body)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.purple.opacity(0.3))
        .cornerRadius(10)
    }

}

// MARK: - Subviews

fileprivate struct Subtitle: View {

    // MARK: - Properties

    let name: String

    // MARK: - View

    var body: some View {
        Text(name)
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }
}

fileprivate struct AddButton: View {

    // MARK: - Properties

    let name: String
    let onAdd: () -> ()

    // MARK: - View

    var body: some View {
        Button(action: {

        }, label: {
            HStack {
                Text("Добавить " + name)
                    .font(.footnote)
                    .foregroundColor(.green)
                Image(systemName: "plus.circle.fill")
                    .font(.footnote)
                    .foregroundColor(.green)
            }
        })
        .padding()
    }
}

fileprivate struct ExpertItemView: View {

    // MARK: - Properties

    let expert: Expert
    let onTap: (Expert) -> ()
    let onDelete: (Expert) -> ()

    // MARK: - View

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(expert.name)
                    .font(.headline)
                    .padding(.bottom)
                HStack {
                    HStack(spacing: 0) {
                        Text("вес: ")
                            .font(.caption2)
                        Text(String(expert.weight))
                            .font(.caption2)
                    }
                    HStack(spacing: 0) {
                        Text("Тип: ")
                            .font(.caption2)
                        Text(String(expert.type.name))
                            .font(.caption2)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(5)
        .onTapGesture {
            onTap(expert)
        }
        .contextMenu {
            Button(action: {
                onTap(expert)
            }) {
                Text("Open")
            }

            Button(action: {
                onDelete(expert)
            }) {
                Text("Delete")
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
            }
        }
    }
}

fileprivate struct VariantItemView: View {

    // MARK: - Properties

    let variant: Variant
    let onDelete: (Variant) -> ()

    // MARK: - View

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(variant.name)
                    .font(.headline)
                    .padding(.bottom)
                HStack {
                    HStack(spacing: 0) {
                        Text("индекс: ")
                            .font(.caption2)
                        Text(String(variant.index))
                            .font(.caption2)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(5)
        .contextMenu {
            Button(action: {
                onDelete(variant)
            }) {
                Text("Delete")
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
            }
        }
    }
}

fileprivate struct ConfidenceItemView: View {

    // MARK: - Properties

    let confidence: Confidence
    let onDelete: (Confidence) -> ()

    // MARK: - View

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(confidence.name)
                    .font(.headline)
                    .padding(.bottom)
                HStack {
                    HStack(spacing: 0) {
                        Text("индекс: ")
                            .font(.caption2)
                        Text(String(confidence.index))
                            .font(.caption2)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.orange.opacity(0.2))
        .cornerRadius(5)
        .contextMenu {
            Button(action: {
                onDelete(confidence)
            }) {
                Text("Delete")
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
            }
        }
    }
}

// MARK: - Previews

struct SessionView_Previews: PreviewProvider {

    static var previews: some View {
        SessionView(vm: MockSessionViewModel(), onSave: { _ in })
    }
}
