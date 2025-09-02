import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends Equatable {
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

  Task copyWith({
    String? id,
    String? name,
    String? category,
    int? frequencyInDays,
    DateTime? lastDone,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      frequencyInDays: frequencyInDays ?? this.frequencyInDays,
      lastDone: lastDone ?? this.lastDone,
    );
  }

  DateTime get nextDueDate {
    return lastDone.add(Duration(days: frequencyInDays));
  }

  @override
  List<Object?> get props => [id, name, category, frequencyInDays, lastDone];

  @override
  bool get stringify => true;
}
