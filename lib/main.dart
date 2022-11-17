import 'dart:async';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:stopwatch_demo/stopwatch.dart';

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
  late Future<StopwatchEx> _stopwatch;
  late Db.MyDatabase _database;
  late int currentId = 1;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    // Initializing variables -------
    _database = Db.MyDatabase();

    // Timer to rerender the page so the text shows the seconds passing by
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _stopwatch.then((stopwatch) => {
            if (stopwatch.isRunning) {setState(() {})}
          });
    });

    // Fetching current stopwatch duration
    _stopwatch = initializeStopwatch();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Deletes all timers
  Future<void> deleteHistoricTimers() async {
    // Deleting persisted timers
    _database.delete(_database.timers).go();

    // Reset stopwatch timer
    final stopwatch = await _stopwatch;
    stopwatch.reset();
    setState(() {});
  }

  Future<StopwatchEx> initializeStopwatch() async {
    // Fetch all the persisted timers
    final allTimers = await _database.select(_database.timers).get();

    if (allTimers.isEmpty) return StopwatchEx();

    // Accumulate the duration of every timer
    Duration accumulativeDuration = const Duration();
    for (Db.Timer timer in allTimers) {
      final stop = timer.stop;
      if (stop != null) {
        accumulativeDuration += stop.difference(timer.start);
      }
    }

    return StopwatchEx(initialOffset: accumulativeDuration);
  }

  // Handles starting and stop
  Future<void> handleStartStop() async {
    final stopwatch = await _stopwatch;
    if (stopwatch.isRunning) {
      // Updating timer of the currentId
      final updatedTimer =
          Db.TimersCompanion(stop: drift.Value(DateTime.now()));

      (_database.update(_database.timers)
            ..where((tbl) => tbl.id.equals(currentId)))
          .write(updatedTimer);

      stopwatch.stop();
      setState(() {});
    } else {
      // Getting the newly created timer ID to change state with
      final insertedId = await _database
          .into(_database.timers)
          .insert(Db.TimersCompanion.insert(start: DateTime.now()));

      stopwatch.start();
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
        child: FutureBuilder<StopwatchEx>(
          future: _stopwatch,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final stopwatch = snapshot.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(formatTime(stopwatch.elapsedMilliseconds),
                        style: const TextStyle(fontSize: 48.0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: FloatingActionButton(
                          onPressed: handleStartStop,
                          child: stopwatch.isRunning
                              ? const Icon(Icons.stop)
                              : const Icon(Icons.play_arrow),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed:
                            !stopwatch.isRunning ? deleteHistoricTimers : null,
                        backgroundColor: stopwatch.isRunning
                            ? Colors.redAccent.shade100
                            : Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
