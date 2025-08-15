import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// Esta linha diz ao gerador de código qual o nome do arquivo a ser criado.
part 'task_model.g.dart';

// Anotação @HiveType. O typeId deve ser único para cada modelo.
@HiveType(typeId: 0)
class Task extends Equatable {
  // @HiveField para cada propriedade, com um índice único.
  // IMPORTANTE: Uma vez definidos, NUNCA mude os índices.
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String category;
  
  @HiveField(3)
  final int frequencyInDays;
  
  @HiveField(4)
  final DateTime lastDone;

  const Task({
    required this.id,
    required this.name,
    required this.category,
    required this.frequencyInDays,
    required this.lastDone,
  });

  DateTime get nextDueDate {
    return lastDone.add(Duration(days: frequencyInDays));
  }
  
  @override
  List<Object?> get props => [id, name, category, frequencyInDays, lastDone];
}