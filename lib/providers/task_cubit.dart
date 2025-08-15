/*

  CUBIT: Simplified version of BLoC (Business Logic Component) for state management in Flutter.

  Responsibilities of the TaskCubit:
    - Load the tasks from the storage.
    - Add a new task.
    - Update a task (when "ready" has been chose).
    - Delete a task.

*/

import 'package:items_list_timer/providers/task_state.dart';
import 'package:items_list_timer/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  // Variável para nossa "caixa" (tabela) de tarefas
  late Box<Task> _taskBox; 

  // Variáveis para armazenar a última tarefa deletada e sua posição na lista
  int? _lastTaskDeletedIndex;
  Task? _lastTaskDeleted;

  Future<void> _initDb() async {
    // Abre a caixa. Se não existir, ela é criada.
    _taskBox = await Hive.openBox<Task>('tasks');
  }

  Future<void> loadTasks() async {
    try {
      emit(TaskLoading());
      await _initDb(); // Garante que o DB está aberto
      
      // Carrega as tarefas do banco de dados e as converte para uma lista
      final tasks = _taskBox.values.toList();
      
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Não foi possível carregar as tarefas do banco de dados."));
    }
  }

  Future<void> _updateDb(List<Task> tasks) async {
    // Uma forma simples de salvar: limpa a caixa e salva a lista atualizada.
    await _taskBox.clear();
    // O Hive usa um mapa de Chave-Valor.
    final Map<String, Task> taskMap = {for (var task in tasks) task.id: task};
    await _taskBox.putAll(taskMap);
  }

  Future<void> addTask(Task task) async {
    if (state is TaskLoaded) {
      final updatedTasks = List<Task>.from((state as TaskLoaded).tasks)..add(task);
      emit(TaskLoaded(updatedTasks));
      await _updateDb(updatedTasks); // Salva no DB
    }
  }
  
  Future<void> markTaskAsDone(String taskId) async {
    if (state is TaskLoaded) {
      final currentTasks = (state as TaskLoaded).tasks;
      final updatedTasks = currentTasks.map((task) {
        if (task.id == taskId) {
          return Task(
            id: task.id,
            name: task.name,
            category: task.category,
            frequencyInDays: task.frequencyInDays,
            lastDone: DateTime.now(),
          );
        }
        return task;
      }).toList();
      emit(TaskLoaded(updatedTasks));
      await _updateDb(updatedTasks); // Salva no DB
    }
  }

  Future<void> deleteTask(Task task) async {
    if (state is TaskLoaded) {
      final currentTasks = List<Task>.from((state as TaskLoaded).tasks);
      _lastTaskDeleted = task;
      _lastTaskDeletedIndex = currentTasks.indexOf(task);
      currentTasks.remove(task);
      emit(TaskLoaded(currentTasks));
      await _updateDb(currentTasks); // Salva no DB
    }
  }

  Future<void> undoDelete() async {
    if (_lastTaskDeleted == null || _lastTaskDeletedIndex == null) return;
    if (state is TaskLoaded) {
      final currentTasks = List<Task>.from((state as TaskLoaded).tasks);
      currentTasks.insert(_lastTaskDeletedIndex!, _lastTaskDeleted!);
      emit(TaskLoaded(currentTasks));
      await _updateDb(currentTasks); // Salva no DB
      _lastTaskDeleted = null;
      _lastTaskDeletedIndex = null;
    }
  }
}