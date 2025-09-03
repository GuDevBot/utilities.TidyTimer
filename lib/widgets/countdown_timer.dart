import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;
  final bool showSeconds;

  const CountdownTimer({
    super.key,
    required this.targetDate,
    this.showSeconds = false,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateTimeRemaining();

    _timer = Timer.periodic(Duration(seconds: widget.showSeconds ? 1 : 60), (
      timer,
    ) {
      _updateTimeRemaining();
    });
  }

  void _updateTimeRemaining() {
    final now = DateTime.now();
    if (widget.targetDate.isAfter(now)) {
      setState(() {
        _timeRemaining = widget.targetDate.difference(now);
      });
    } else {
      setState(() {
        _timeRemaining = Duration.zero;
      });
      _timer.cancel();
    }
  }

  // Its important to cancel the timer to avoid memory leaks
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
    final seconds = duration.inSeconds % 60;

    String result = '';
    if (days > 0) {
      result += '$days d ';
    }
    if (hours > 0) {
      result += '$hours h ';
    }
    if (minutes > 0) {
      result += '$minutes min ';
    }
    if (widget.showSeconds && days >= 0 && hours >= 0) {
      result += '$seconds seg';
    }

    return result.trim();
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatDuration(_timeRemaining);
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
        fontWeight: _timeRemaining.inSeconds <= 0
            ? FontWeight.bold
            : FontWeight.normal,
      ),
    );
  }
}
