import 'dart:async';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:stopwatch_demo/stopwatch.dart';

import 'database.dart' as db;
import 'utils.dart';

main() {
  runApp(const MaterialApp(title: 'Stopwatch Example', home: StopwatchPage()));
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Future<StopwatchEx> _stopwatch;
  late db.MyDatabase _database;
  late int _currentId = 1;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    // Initializing variables -------
    _database = db.MyDatabase();
    _stopwatch = initializeStopwatch();

    // Timer to rerender the page so the text shows the seconds passing by
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _stopwatch.then((stopwatch) => {
            if (stopwatch.isRunning) {setState(() {})}
          });
    });
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

  // Initializes stop watch
  Future<StopwatchEx> initializeStopwatch() async {

    // Fetch all the persisted timers
    final allTimers = await _database.select(_database.timers).get();

    if (allTimers.isEmpty) return StopwatchEx();

    // Accumulate the duration of every timer
    Duration accumulativeDuration = const Duration();
    for (db.Timer timer in allTimers) {
      final stop = timer.stop;
      if (stop != null) {
        accumulativeDuration += stop.difference(timer.start);
      }
    }

    return StopwatchEx(initialOffset: accumulativeDuration);
  }

  // Handles starting and stop events
  Future<void> handleStartStop() async {
    final stopwatch = await _stopwatch;

    if (stopwatch.isRunning) {

      // Updating timer of the currentId
      final updatedTimer =
          db.TimersCompanion(stop: drift.Value(DateTime.now()));

      (_database.update(_database.timers)
            ..where((tbl) => tbl.id.equals(_currentId)))
          .write(updatedTimer);

      stopwatch.stop();
      setState(() {});

    } else {

      // Getting the newly created timer ID to change state with
      final insertedId = await _database
          .into(_database.timers)
          .insert(db.TimersCompanion.insert(start: DateTime.now()));

      stopwatch.start();

      setState(() {
        _currentId = insertedId;
      });
    }
  }

  // Navigating to page with persisted timers
  void navigateToPersistedTimersListPage() {
    _database
        .select(_database.timers)
        .get()
        .then((allTimers) => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  final tiles = allTimers.map(
                    (timer) {
                      return ListTile(
                        title: Text("ID: ${timer.id}"),
                        subtitle: Text(
                          "Start: ${timer.start} \n"
                          "End: ${timer.stop}",
                        ),
                      );
                    },
                  );
                  final divided = tiles.isNotEmpty
                      ? ListTile.divideTiles(
                          context: context,
                          tiles: tiles,
                        ).toList()
                      : <Widget>[];

                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Persisted timers'),
                    ),
                    body: ListView(children: divided),
                  );
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: navigateToPersistedTimersListPage,
            tooltip: 'completed todo list',
          ),
        ],
      ),
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
                          heroTag: "startstop_btn",
                          onPressed: handleStartStop,
                          child: stopwatch.isRunning
                              ? const Icon(Icons.stop)
                              : const Icon(Icons.play_arrow),
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "delete_btn",
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
