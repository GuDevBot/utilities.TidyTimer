import 'package:tidytimer/providers/task_cubit.dart';
import 'package:tidytimer/providers/theme_cubit.dart';
import 'package:tidytimer/screens/home_screen.dart';
import 'package:tidytimer/models/task_model.dart';
import 'package:tidytimer/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubit()..initialize()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TidyTimer',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
