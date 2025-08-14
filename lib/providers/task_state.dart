import 'package:equatable/equatable.dart';
import '../models/task_model.dart'; // Importe seu modelo de Task

// Classe base para todos os estados.
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

// Estado inicial, quando nada aconteceu ainda.
class TaskInitial extends TaskState {}

// Estado de carregamento, para mostrar um CircularProgressIndicator.
class TaskLoading extends TaskState {}

// Estado de sucesso, quando as tarefas foram carregadas.
// Ele carrega a lista de tarefas para a UI poder usar.
class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

// Estado de erro, se algo der errado ao carregar.
class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}