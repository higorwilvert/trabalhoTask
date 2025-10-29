//
//  EditarTarefaView.swift
//  TaskManagerV02
//
//  Created by Guest User on 29/10/25.
//

import SwiftUI

struct EditarTarefaView: View {
    @ObservedObject var viewModel: TarefaViewModel
    @Environment(\.dismiss) var dismiss
    @State var tarefa: Tarefa
    
    @State private var titulo: String = ""
    @State private var categoria: String = ""
    @State private var prioridade: String = ""
    
    @Environment(\.presentationMode) var presentationMode

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

            Button("Salvar alterações") {
                                viewModel.editarTarefa(tarefa,
                                                       novoTitulo: titulo,
                                                       novaCategoria: categoria,
                                                       novaPrioridade: prioridade)
                                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Editar Tarefa")
        .onAppear {
            titulo = tarefa.titulo ?? ""
            categoria = tarefa.categoria ?? ""
            prioridade = tarefa.prioridade ?? ""
        }
    }
}
