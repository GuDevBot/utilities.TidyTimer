/*

  CUBIT: Simplified version of BLoC (Business Logic Component) for state management in Flutter.

  Responsibilities of the TaskCubit:
    - Load the tasks from the storage.
    - Add a new task.
    - Update a task (when "ready" has been chose).
    - Delete a task.

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_state.dart';
import '../models/task_model.dart';

// Este Cubit vai gerenciar um estado do tipo 'TaskState'.
class TaskCubit extends Cubit<TaskState> {
  // Quando o Cubit é criado, seu estado inicial é 'TaskInitial'.
  TaskCubit() : super(TaskInitial());

  // (Aqui viria a conexão com seu StorageService, por enquanto vamos simular)
  final List<Task> _tasks = []; // Uma lista privada para simular o banco de dados

  // Método para carregar as tarefas
  Future<void> loadTasks() async {
    try {
      // 1. Emite o estado de 'Carregando' para a UI mostrar um spinner.
      emit(TaskLoading());

      // 2. Simula uma chamada ao banco de dados.
      await Future.delayed(const Duration(seconds: 1)); 
      // Em um app real: _tasks = await storageService.getTasks();

      // 3. Emite o estado de 'Carregado' com a lista de tarefas.
      emit(TaskLoaded(_tasks));
    } catch (e) {
      // 4. Se der erro, emite o estado de 'Erro'.
      emit(TaskError("Não foi possível carregar as tarefas."));
    }
  }

  // Método para adicionar uma nova tarefa
  Future<void> addTask(Task task) async {
    // A lógica é a mesma: pega o estado atual, modifica e emite um novo.
    if (state is TaskLoaded) {
      final currentTasks = (state as TaskLoaded).tasks;
      final updatedTasks = List<Task>.from(currentTasks)..add(task);
      // Em um app real: await storageService.saveTasks(updatedTasks);
      emit(TaskLoaded(updatedTasks));
    }
  }
  
  // Método para marcar uma tarefa como feita
  Future<void> markTaskAsDone(String taskId) async {
    if (state is TaskLoaded) {
      final List<Task> currentTasks = (state as TaskLoaded).tasks;
      
      final updatedTasks = currentTasks.map((task) {
        if (task.id == taskId) {
          // Cria uma nova instância da tarefa com a data atualizada
          return Task(
            id: task.id,
            name: task.name,
            category: task.category,
            frequencyInDays: task.frequencyInDays,
            lastDone: DateTime.now(), // A MÁGICA ACONTECE AQUI!
          );
        }
        return task;
      }).toList();
      
      emit(TaskLoaded(updatedTasks));
      // Em um app real: await storageService.saveTasks(updatedTasks);
    }
  }
}