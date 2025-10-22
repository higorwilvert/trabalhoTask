//
//  TarefaViewModel.swift
//  TaskManagerV02
//
//  Created by Guest User on 22/10/25.
//

import Foundation
import CoreData
internal import Combine

class TarefaViewModel: ObservableObject {
    var objectWillChange: ObservableObjectPublisher!
    
    @Published var tarefas: [Tarefa] = []
    private let context = PersistenceController.shared.container.viewContext

    func fetchTarefas(filtro: String? = nil) {
        let request: NSFetchRequest<Tarefa> = Tarefa.fetchRequest()
        if let filtro = filtro, !filtro.isEmpty {
            request.predicate = NSPredicate(format: "titulo CONTAINS[cd] %@", filtro)
        }
        do {
            tarefas = try context.fetch(request)
        } catch {
            print("Erro ao buscar tarefas: \(error)")
        }
    }

    func adicionarTarefa(titulo: String, categoria: String, prioridade: String) {
        let nova = Tarefa(context: context)
        nova.id = UUID()
        nova.titulo = titulo
        nova.categoria = categoria
        nova.prioridade = prioridade
        nova.concluida = false
        nova.dataCriacao = Date()
        salvar()
        fetchTarefas()
    }

    func editarTarefa(_ tarefa: Tarefa, novoTitulo: String, novaCategoria: String, novaPrioridade: String) {
        tarefa.titulo = novoTitulo
        tarefa.categoria = novaCategoria
        tarefa.prioridade = novaPrioridade
        salvar()
        fetchTarefas()
    }

    func excluirTarefa(_ tarefa: Tarefa) {
        context.delete(tarefa)
        salvar()
        fetchTarefas()
    }

    func marcarComoConcluida(_ tarefa: Tarefa) {
        tarefa.concluida.toggle()
        salvar()
        fetchTarefas()
    }

    private func salvar() {
        do {
            try context.save()
        } catch {
            print("Erro ao salvar tarefa: \(error)")
        }
    }
}
