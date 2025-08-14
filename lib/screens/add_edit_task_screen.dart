/*

  A simple form with spaces for the task name, frequency, category

  Save button

*/

// Para gerar IDs únicos
import 'package:items_list_timer/providers/task_cubit.dart'; 
import 'package:items_list_timer/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// 1. Transformamos em um StatefulWidget
class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

// 2. Esta é a classe de "Estado" que guarda as variáveis do formulário
class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  // Variáveis para guardar os dados do formulário
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  double _frequencyInDays = 7.0; // Valor inicial do slider (7 dias)

  // É importante limpar os controllers quando o widget é descartado
  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O nome da tarefa não pode estar vazio!')),
      );
      return;
    }

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(1000).toString(),
      name: _nameController.text,
      category: _categoryController.text.isNotEmpty ? _categoryController.text : 'Geral',
      frequencyInDays: _frequencyInDays.toInt(), // Convertemos o double para inteiro
      lastDone: DateTime.now(),
    );

    // Usamos o Cubit para adicionar a nova tarefa
    context.read<TaskCubit>().addTask(newTask);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Tarefa',
                hintText: 'Ex: Limpar o fogão',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Categoria (Opcional)',
                hintText: 'Ex: Cozinha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Refazer a cada: ${_frequencyInDays.toInt()} dias',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _frequencyInDays,
              min: 1,
              max: 90,
              divisions: 89,
              label: '${_frequencyInDays.toInt()} dias',
              onChanged: (newValue) {
                setState(() {
                  _frequencyInDays = newValue;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Salvar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}