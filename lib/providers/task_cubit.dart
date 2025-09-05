import 'package:tidytimer/providers/task_state.dart';
import 'package:tidytimer/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskCubit extends Cubit<TaskState> {
  int? _lastTaskDeletedIndex;
  Task? _lastTaskDeleted;
  late Box<Task> _taskBox;
  bool _initialized = false;

  TaskCubit() : super(TaskInitial());

  Future<void> initialize() async {
    _taskBox = await Hive.openBox<Task>('tasks');
    _initialized = true;
    await loadTasks();
  }

  Future<void> _emitTasksFromBox() async {
    final tasks = _taskBox.values.toList();
    tasks.sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
    emit(TaskLoaded(tasks));
  }

  Future<void> loadTasks() async {
    if (!_initialized) return;
    try {
      emit(TaskLoading());
      await _emitTasksFromBox();
    } catch (e) {
      emit(
        TaskError("Não foi possível carregar as tarefas do banco de dados."),
      );
    }
  }

  Future<void> addTask(Task task) async {
    if (!_initialized || state is! TaskLoaded) return;
    if (state is TaskLoaded) {
      try {
        await _taskBox.put(task.id, task);
        _emitTasksFromBox();
      } catch (e) {
        emit(
          TaskError("Não foi possível adicionar a tarefa. Tente novamente."),
        );
      }
    }
  }

  Future<void> markTaskAsDone(String taskId) async {
    if (state is! TaskLoaded) return;
    final currentTasks = (state as TaskLoaded).tasks;
    try {
      final updatedTask = currentTasks
          .firstWhere((task) => task.id == taskId)
          .copyWith(lastDone: DateTime.now());
      await _taskBox.put(updatedTask.id, updatedTask);
      _emitTasksFromBox();
    } catch (e) {
      emit(
        TaskError(
          "Não foi possível marcar a tarefa como concluída. Tente novamente.",
        ),
      );
    }
  }

  Future<void> deleteTask(Task task) async {
    if (state is TaskLoaded) {
      final currentTasks = List<Task>.from((state as TaskLoaded).tasks);
      _lastTaskDeleted = task;
      _lastTaskDeletedIndex = currentTasks.indexOf(task);
      currentTasks.remove(task);
      emit(TaskLoaded(currentTasks));
      await _taskBox.delete(task.id);
    }
  }

  Future<void> undoDelete() async {
    if (_lastTaskDeleted == null || _lastTaskDeletedIndex == null) return;
    if (state is TaskLoaded) {
      final currentTasks = List<Task>.from((state as TaskLoaded).tasks);
      currentTasks.insert(_lastTaskDeletedIndex!, _lastTaskDeleted!);
      emit(TaskLoaded(currentTasks));
      await _taskBox.put(_lastTaskDeleted!.id, _lastTaskDeleted!);
      _lastTaskDeleted = null;
      _lastTaskDeletedIndex = null;
    }
  }
}
