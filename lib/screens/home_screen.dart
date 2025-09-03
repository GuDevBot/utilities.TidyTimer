import 'package:tidytimer/providers/theme_cubit.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('TidyTimer'),
        toolbarHeight: 65,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading || state is TaskInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is! TaskLoaded) {
          } else {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text('No tasks found. Add a new task!'),
              );
            }
            // If we reach here, we have tasks to show.
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                final isMostUrgent = index == 0;
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (direction) {
                    final cubit = context.read<TaskCubit>();
                    cubit.deleteTask(task);
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('${task.name} deleted.'),
                          duration: const Duration(seconds: 4),
                          action: SnackBarAction(
                            label: 'UNDO',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Deleting...',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.delete_forever, color: Colors.white),
                      ],
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 19),
                    elevation: 2,
                    child: ListTile(
                      title: Text(task.name),
                      subtitle: CountdownTimer(
                        targetDate: task.nextDueDate,
                        showSeconds: isMostUrgent,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check_circle_outline),
                        onPressed: () {
                          context.read<TaskCubit>().markTaskAsDone(task.id);
                        },
                      ),
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
