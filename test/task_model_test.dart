import 'package:flutter_test/flutter_test.dart';
import 'package:tidytimer/models/task_model.dart';

void main() {
  test('Task equality test', () {
    final task1 = Task(
      id: "abc123",
      name: "Limpar casa",
      category: "Lar",
      frequencyInDays: 7,
      lastDone: DateTime(2025, 09, 01),
    );

    final task2 = Task(
      id: "abc123",
      name: "Limpar casa",
      category: "Lar",
      frequencyInDays: 7,
      lastDone: DateTime(2025, 09, 01),
    );

    final task3 = Task(
      id: "def456",
      name: "Lavar roupa",
      category: "Lar",
      frequencyInDays: 3,
      lastDone: DateTime(2025, 08, 30),
    );

    expect(task1, equals(task2));
    expect(task1, isNot(equals(task3)));
  });
}