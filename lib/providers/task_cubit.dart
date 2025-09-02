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

  Future<void> loadTasks() async {
    if (!_initialized) return;
    try {
      emit(TaskLoading());
      final tasks = _taskBox.values.toList();
      tasks.sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(
        TaskError("Não foi possível carregar as tarefas do banco de dados."),
      );
    }
  }

  Future<void> addTask(Task task) async {
    if (!_initialized || state is! TaskLoaded) return;
    if (state is TaskLoaded) {
      final updatedTasks = List<Task>.from((state as TaskLoaded).tasks)
        ..add(task);
      emit(TaskLoaded(updatedTasks));
      await _taskBox.put(task.id, task);
    }
  }

  Future<void> markTaskAsDone(String taskId) async {
    if (state is! TaskLoaded) return;
    final currentTasks = (state as TaskLoaded).tasks;
    final updatedTasks = currentTasks.map((task) {
      if (task.id == taskId) {
        final updatedTask = task.copyWith(lastDone: DateTime.now());
        _taskBox.put(updatedTask.id, updatedTask);
        return updatedTask;
      }
      return task;
    }).toList();

    updatedTasks.sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
    emit(TaskLoaded(updatedTasks));
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
