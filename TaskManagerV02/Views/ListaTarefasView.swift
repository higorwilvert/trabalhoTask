//
//  ListaTarefasView.swift
//  TaskManagerV02
//
//  Created by Guest User on 22/10/25.
//

import SwiftUI

struct ListaTarefasView: View {
    @StateObject private var viewModel = TarefaViewModel()
    @State private var busca = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar tarefa...", text: $busca)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: busca) { _ in
                        viewModel.fetchTarefas(filtro: busca)
                    }

                List {
                    ForEach(viewModel.tarefas) { tarefa in
                        HStack {
                            Button(action: {
                                viewModel.marcarComoConcluida(tarefa)
                            }) {
                                Image(systemName: tarefa.concluida ? "checkmark.circle.fill" : "circle")
                            }
                            VStack(alignment: .leading) {
                                Text(tarefa.titulo!)
                                    .strikethrough(tarefa.concluida)
                                Text("\(tarefa.categoria) • \(tarefa.prioridade)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map { viewModel.tarefas[$0] }.forEach(viewModel.excluirTarefa)
                    }
                }
            }
            .navigationTitle("Minhas Tarefas")
            .toolbar {
                NavigationLink(destination: NovaTarefaView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            }
            .onAppear {
                viewModel.fetchTarefas()
            }
        }
    }
}
