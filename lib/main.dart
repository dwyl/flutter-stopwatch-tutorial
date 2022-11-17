import 'dart:async';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

import 'database.dart' as Db;

main() {
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
  late Db.MyDatabase _database;
  late int currentId = 1;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    _database = Db.MyDatabase();

    _stopwatch = Stopwatch();

    // Timer to rerender the page so the text shows the seconds passing by
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Deletes all timers
  Future<void> deleteHistoricTimers() async {
    _database.delete(_database.timers).go();
  }

  // Handles starting and stop
  Future<void> handleStartStop() async {
    if (_stopwatch.isRunning) {
      // Updating timer of the currentId
      final updatedTimer =
          Db.TimersCompanion(stop: drift.Value(DateTime.now()));

      (_database.update(_database.timers)
            ..where((tbl) => tbl.id.equals(currentId)))
          .write(updatedTimer);

      //final allTimers = await _database.select(_database.timers).get();
      //print(allTimers);

      _stopwatch.stop();
      setState(() {});
    } else {
      // Getting the newly created timer ID to change state with
      final insertedId = await _database
          .into(_database.timers)
          .insert(Db.TimersCompanion.insert(start: DateTime.now()));

      _stopwatch.start();
      setState(() {
        currentId = insertedId;
      });
    }
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
            Text(currentId.toString()),
            ElevatedButton(
                onPressed: handleStartStop,
                child: Text(_stopwatch.isRunning ? 'Stop' : 'Start')),
            ElevatedButton(
                onPressed: deleteHistoricTimers,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(color: Colors.white)),
                child: const Text('Delete')),
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