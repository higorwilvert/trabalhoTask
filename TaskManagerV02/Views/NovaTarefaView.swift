//
//  NovaTarefaView.swift
//  TaskManagerV02
//
//  Created by Guest User on 22/10/25.
//

import SwiftUI

struct NovaTarefaView: View {
    @ObservedObject var viewModel: TarefaViewModel
    @Environment(\.dismiss) var dismiss

    @State private var titulo = ""
    @State private var categoria = "Pessoal"
    @State private var prioridade = "Média"

    var body: some View {
        Form {
            TextField("Título", text: $titulo)

            Picker("Categoria", selection: $categoria) {
                ForEach(["Trabalho", "Estudo", "Pessoal"], id: \.self) {
                    Text($0)
                }
            }

            Picker("Prioridade", selection: $prioridade) {
                ForEach(["Alta", "Média", "Baixa"], id: \.self) {
                    Text($0)
                }
            }

            Button("Salvar") {
                viewModel.adicionarTarefa(titulo: titulo, categoria: categoria, prioridade: prioridade)
                dismiss()
            }
        }
        .navigationTitle("Nova Tarefa")
    }
}
