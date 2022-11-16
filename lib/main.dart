import 'dart:async';

import 'package:flutter/material.dart';

import 'database.dart' as Db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = Db.MyDatabase();

  // Simple select:
  final allTimers = await database.select(database.timers).get();
  print('Timers in database: $allTimers');

  runApp(MyApp());
}

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Stopwatch Example', home: StopwatchPage());
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {}); // re-render the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(formatTime(_stopwatch.elapsedMilliseconds),
                style: const TextStyle(fontSize: 48.0)),
            ElevatedButton(
                onPressed: handleStartStop,
                child: Text(_stopwatch.isRunning ? 'Stop' : 'Start')),
          ],
        ),
      ),
    );
  }
}

/*
import 'database.dart' as Db;

Future<void> main() async {
  final database = Db.MyDatabase();

  // Simple select:
  final allTimers = await database.select(database.timers).get();
  print('Categories in database: $allTimers');

  runApp(MyApp());
}
*/