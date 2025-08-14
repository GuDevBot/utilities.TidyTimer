/*

  Inicialize the Hive and the TaskCubit
  The TaskCubit load the tasks from the storage
  The HomeScreen hear the TaskCubit and rebuild the UI when the tasks immediately.

*/

import 'package:items_list_timer/providers/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..loadTasks(), // Cria o Cubit e já manda carregar as tarefas
      child: MaterialApp(
        title: 'Items List Timer',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}







































