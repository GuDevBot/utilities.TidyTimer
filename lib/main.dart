/*

  Inicialize the Hive and the TaskCubit
  The TaskCubit load the tasks from the storage
  The HomeScreen hear the TaskCubit and rebuild the UI when the tasks immediately.

*/

import 'package:items_list_timer/providers/task_cubit.dart';
import 'package:items_list_timer/screens/home_screen.dart';
import 'package:items_list_timer/models/task_model.dart';
import 'package:items_list_timer/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

// A função main agora precisa ser 'async'
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive
  await Hive.initFlutter();
  
  // Registra nosso adaptador gerado
  Hive.registerAdapter(TaskAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..loadTasks(),
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