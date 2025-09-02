import 'package:tidytimer/providers/task_cubit.dart';
import 'package:tidytimer/providers/task_state.dart';
import 'package:tidytimer/models/task_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hive/hive.dart';

void main() {
  late TaskCubit taskCubit;
  late Box<Task> taskBox;

  final task = Task(
    id: '1',
    name: 'Teste',
    category: 'Geral',
    frequencyInDays: 7,
    lastDone: DateTime.now(),
  );

  setUp(() async {
    await setUpTestHive();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
    taskBox = await Hive.openBox<Task>('tasks');
  });

  tearDown(() async {
    await taskBox.clear();
    await taskBox.close();
    await tearDownTestHive();
  });

  blocTest<TaskCubit, TaskState>(
    'emits [TaskInitial, TaskLoading, TaskLoaded] when initialized',
    setUp: () => taskCubit = TaskCubit(),
    build: () => taskCubit,
    act: (cubit) async => await cubit.initialize(),
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskLoaded>(),
    ],
  );

  blocTest<TaskCubit, TaskState>(
    'emits TaskLoaded with added task when addTask is called',
    setUp: () => taskCubit = TaskCubit(),
    build: () => taskCubit,
    act: (cubit) async {
      await cubit.initialize();
      await cubit.addTask(task);
    },
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskLoaded>().having((state) => state.tasks.isEmpty, 'tasks empty', true),
      isA<TaskLoaded>().having((state) => state.tasks.length, 'tasks length', 1),
    ],
  );

  blocTest<TaskCubit, TaskState>(
    'emits TaskLoaded with task marked as done when markTaskAsDone is called',
    setUp: () => taskCubit = TaskCubit(),
    build: () => taskCubit,
    seed: () => TaskLoaded([task]),
    act: (cubit) async => await cubit.markTaskAsDone(task.id),
    expect: () => [
      isA<TaskLoaded>().having(
          (state) => state.tasks.first.lastDone.isAfter(task.lastDone),
          'lastDone updated',
          true),
    ],
  );

  blocTest<TaskCubit, TaskState>(
    'emits TaskLoaded without task when deleteTask is called',
    setUp: () => taskCubit = TaskCubit(),
    build: () => taskCubit,
    seed: () => TaskLoaded([task]),
    act: (cubit) async => await cubit.deleteTask(task),
    expect: () => [
      isA<TaskLoaded>().having((state) => state.tasks.isEmpty, 'tasks empty', true),
    ],
  );

  blocTest<TaskCubit, TaskState>(
    'undoDelete restores the last deleted task',
    setUp: () => taskCubit = TaskCubit(),
    build: () => taskCubit,
    seed: () => TaskLoaded([task]),
    act: (cubit) async {
      await cubit.deleteTask(task);
      await cubit.undoDelete();
    },
    expect: () => [
      isA<TaskLoaded>().having((state) => state.tasks.isEmpty, 'tasks empty', true),
      isA<TaskLoaded>().having((state) => state.tasks.length, 'tasks length', 1),
    ],
  );
}