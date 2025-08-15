/*

  Use the ListView.builder constructor to create a scrollable tasks list.

  Order the tasks by urgency, with the most urgent tasks at the top.

  Actions:
    - A "+" button to call the AddEditTaskScreen.
    - A checkbox to mark a task as "ready" (completed).

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_list_timer/providers/task_cubit.dart';
import 'package:items_list_timer/providers/task_state.dart';
import 'add_edit_task_screen.dart';

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
      // O BlocBuilder é o widget que "ouve" o Cubit e se reconstrói.
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          // Agora, dependendo do estado, mostramos uma coisa diferente.
          if (state is TaskLoading || state is TaskInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text('Nenhuma tarefa ainda. Adicione uma!'),
              );
            }
            // Se há tarefas, mostramos a lista.
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (direction) {
                    final cubit = context.read<TaskCubit>();
                    cubit.deleteTask(task);

                    // Mostra um snackbar para dar um feedback e a opção de desfazer (Undo)
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar() // Remove o snackbar anterior, se houver
                      ..showSnackBar(
                        SnackBar(
                          content: Text('${task.name} deletado.'),
                          duration: const Duration(seconds: 4),
                          // Ação de desfazer
                          action: SnackBarAction(
                            label: 'DESFAZER',
                            onPressed: () {
                              cubit.undoDelete();
                            },
                          ),
                        ),
                      );
                  },

                  // 'background' que aparece por trás enquanto o usuário arrasta.
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
                    subtitle: Text(
                      'Próxima vez: ${task.nextDueDate.toLocal().toString().substring(0, 10)}',
                    ),
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

          // Estado padrão, caso algo inesperado aconteça.
          return const Center(child: Text('Algo deu errado.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quando o botão "+" é pressionado, vamos para a tela de adicionar/editar tarefa.
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
