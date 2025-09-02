/*

  Use the ListView.builder constructor to create a scrollable tasks list.

  Order the tasks by urgency, with the most urgent tasks at the top.

  Actions:
    - A "+" button to call the AddEditTaskScreen.
    - A checkbox to mark a task as "ready" (completed).

*/

import 'package:tidytimer/widgets/countdown_timer.dart';
import 'package:tidytimer/providers/task_cubit.dart';
import 'package:tidytimer/providers/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'task_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading || state is TaskInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is! TaskLoaded) {}
          else {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text('Nenhuma tarefa ainda. Adicione uma!'),
              );
            }
            // If we reach here, we have tasks to show. 
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (direction) {
                    final cubit = context.read<TaskCubit>();
                    cubit.deleteTask(task);
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('${task.name} deletado.'),
                          duration: const Duration(seconds: 4),
                          action: SnackBarAction(
                            label: 'DESFAZER',
                            onPressed: () {
                              cubit.undoDelete();
                            },
                          ),
                        ),
                      );
                  },
                  background: Container(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: CountdownTimer(targetDate: task.nextDueDate),
                    trailing: IconButton(
                      icon: const Icon(Icons.check_circle_outline),
                      onPressed: () {
                        context.read<TaskCubit>().markTaskAsDone(task.id);
                      },
                    ),
                  ),
                );
              },
            );
          }

          if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong!'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
