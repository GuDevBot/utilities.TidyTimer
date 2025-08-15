import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;

  const CountdownTimer({super.key, required this.targetDate});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    // Inicia o cálculo do tempo restante
    _updateTimeRemaining();
    
    // Cria um timer que vai rodar a cada minuto para atualizar a UI
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateTimeRemaining();
    });
  }

  void _updateTimeRemaining() {
    final now = DateTime.now();
    // Garante que a contagem pare quando o tempo acabar
    if (widget.targetDate.isAfter(now)) {
      setState(() {
        _timeRemaining = widget.targetDate.difference(now);
      });
    } else {
      // Se a data já passou, zera a duração e para o timer
      setState(() {
        _timeRemaining = Duration.zero;
      });
      _timer.cancel();
    }
  }

  // É crucial cancelar o timer para evitar vazamentos de memória
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds <= 0) {
      return "Atrasado!";
    }

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    String result = '';
    if (days > 0) {
      result += '$days d ';
    }
    if (hours > 0) {
      result += '$hours h ';
    }
    // Mostra os minutos apenas se o tempo total for menor que 1 dia
    // para não poluir a tela.
    if (days == 0 && minutes > 0) {
      result += '$minutes min';
    }

    return result.isEmpty ? "Menos de 1 min" : result.trim();
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatDuration(_timeRemaining);
    
    // Adiciona uma cor para destacar tarefas atrasadas ou urgentes
    Color textColor = Colors.grey.shade600;
    if (_timeRemaining.inSeconds <= 0) {
      textColor = Colors.red.shade700;
    } else if (_timeRemaining.inDays < 1) {
      textColor = Colors.orange.shade800;
    }

    return Text(
      formattedTime,
      style: TextStyle(
        color: textColor,
        fontWeight: _timeRemaining.inSeconds <= 0 ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}