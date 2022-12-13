
<div align="center">

# Flutter Stopwatch App ⏱

<span>A tutorial for building a basic stopwatch from scratch using flutter.</span>

</div>

# What? 🤷‍♀️
This is a quick tutorial 
that will get you up-and-running
in less than **20 minutes** 
with a simple app 
that works as a stopwatch 
which also *persists*
state in-between sessions. 

# Why? 💡
We wanted to build a simple Flutter app 
with a stopwatch to test 
complexity before adding this to our [`app`](https://github.com/dwyl/app).

# Giving it a whirl 📲
You can (and should) 
try the finished app before trying to build it.
Simply clone this project, 
fetch the dependencies
and get it running!

```sh
git clone https://github.com/dwyl/flutter-stopwatch-tutorial.git

cd flutter-stopwatch-tutorial

flutter pub get
```

If this is your time running a Flutter app,
either be it on a real device or an emulator,
please check the [`learn-flutter`](https://github.com/dwyl/learn-flutter/tree/update-info#installing-flutter-%EF%B8%8F)
repository to setup everything you need 
to get started on your Flutter journey!

After all of this, 
you can simply run the app
and give it a try!

## Running on a real device
If you are interested in running the app 
on your Android or iOS device,
you should follow these instructions.

### Android
Running the app on an Android device is quite easy.
You first need to [enable developer options](https://developer.android.com/studio/debug/dev-options) 
and USB debugging on your device.
You can tap your `device build number` several times
and the "Developer Options" option will come up.
Now it's just a matter of enabling `USB debugging` as well, 
and you should be sorted.

After this, you just plug your phone
to your computer with a USB cable. 
You can check if the device is properly connected 
by running:

```sh
flutter devices
```

And you should be able to see the connected phone.

![connected_device](https://user-images.githubusercontent.com/17494745/201946732-a45299e6-66b4-4ef2-9499-f62a2190ec2c.png)

If you are using Visual Studio, 
you can choose the device
in the bottom bar 
and pick your phone. 
To run, 
simply press `F5` or `Run > Start debugging`
and the build process will commence,
and the app will be running on your phone!

> If this is your first time running on an Android device/emulator, 
> it might take some time so Gradle downloads all the needed dependencies,
> binaries and respective SDKs to build the app to be run on the app. 
> Just make sure you have a solid internet connection. 

> **Do not** interrupt the the building process on the first setup.
> This will result in a corrupted `.gradle` file 
> and you need to clean up to get the app working again.
> If this happens to you, 
> check the [`learn-flutter`](https://github.com/dwyl/flutter-counter-example/tree/update-info#running-on-a-real-device-) repo
> in the `Running on a real device` section to fix this issue.

### iOS
The process is a wee more complicated
because you need an **Apple ID**
to sign up for a [`Developer Account`](https://developer.apple.com/programs/enroll/).

After this having your Developr Account, 
open `XCode` and sign in with your ID 
(inside `Preferences > Accounts`).

![preferences](https://user-images.githubusercontent.com/17494745/202515691-d4d3832b-8b6e-4e3b-953f-9c01b4a87228.png)

Inside `Manager Certificates`, 
click on the "+" sign and
select `iOS Development`.

![certificates](https://user-images.githubusercontent.com/17494745/202516745-ba05bfac-20db-492f-9580-3aa7cc09803a.png)

After this, 
plug the device to your computer.
Find the device in the dropdown (`Window > Organizer`).
Below the team pop-up menu, 
click on `Fix Issue`
and then on `XCode` click the `Run` button.

In subsequent runs, 
you can deploy with VSCode
or any other IDE. 
This certificate setup is only needed on the first time with XCode.

## Demo
Here's a quick demo of what the app will look like,
running on an OnePlus 6T.

We're going to have a **stopwatch** 
that persists each `timer` 
that is created everytime it's paused.
This way,
we are saving not only the amount of times
the stopwatch was stopped and restarted but also when.

![demo](https://user-images.githubusercontent.com/17494745/202527641-95b5b33c-1824-47e0-ac75-4286497a3d1b.gif)


# How? 💻

## Project setup 
Let's get cracking! 

In this walkthrough, 
we are going to use Visual Studio Code. 
We will assume you have this IDE installed, 
as well as the Flutter and Dart extensions installed. 
If not, do so.

![extensions](https://user-images.githubusercontent.com/17494745/200812248-0c9336da-74aa-49ff-9aba-758501f4dce2.png)

After restarting VSCode, we can now create our project!
Click on `View > Command Palette`, 
type "Flutter" and click on `Flutter: New Project`. 
It will ask you for a name of the new project. 
Name it `stopwatch_demo`.

To run the app, follow the previous steps
if you want to run on a real device.
If you want to run on an emulator, click on the **device button**
in the bottom bar in VS Code, choose the device you want to run in
and you should be set!
Now simply press `F5` or `Run > Start debugging` and 
wait for the build process to finish.

Your app should look like this 
(we are running on an iPhone 14 Pro Max emulator).

![boilerplate](https://user-images.githubusercontent.com/17494745/200814531-31579684-e6ec-4da4-a504-642eb31fedb9.png)

Congrats, you got the default app running! :tada:

## Basic stopwatch 
Now let's add a basic stopwatch to our application.
In the `main.dart` file, 
replace the code with the following snippet.

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  runApp(MyApp());
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
```

Inside the `lib` directory, 
create a new  file called `utils.dart` 
and add the following code to it.

```dart
String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}
```

Let's breakdown the changes we just made.
In the `main.dart` file,
we are creating a **stateful widget** 
(a widget that is not static) `StopwatchPage`.
These widgets have a _state_, 
which makes the widget dynamic throughout its lifetime. 
When creating a stateful widget,
a state class is created alongside it, 
representing the state of the widget
and determines what is built and shown to the user.

In this `StopwatchPage` widget, 
we are adding two fields to its state:
`_stopwatch` and `_timer`. 
The first one is literally a [`Stopwatch`](https://api.dart.dev/be/180360/dart-core/Stopwatch-class.html)
class that is offered by the Dart SDK natively. 
This class allows us to `start`, `stop` and `reset` a stopwatch.
It's a rather simple implementation. 
However, there are not any hooks 
that we have that lets us rerender the UI. 
Therefore, 
we create the second field `_timer`,
which will rerender the `Text` 
containing the time elapsed every **200ms**.

In the UI, we have two buttons. 
One button toggles between `Start` and `Stop`, 
which is handled by the `handleStartStop` handler. 
At the end of the handler,
we add a `setState(() {})`, 
which forces a re-render of the UI.

The `Text` showing the time elapsed makes use of the
`formatTime` function we added to `utils.dart`
to correctly format 
and show the elapsed time.

Your app should now look like this.

<img width="600" alt="basic_setup" src="https://user-images.githubusercontent.com/17494745/202561805-a9e60139-027e-4e7c-9a43-d411652432a4.png">

You can press the button 
and it will toggle between "start" and "stop",
pausing and restarting the stopwatch. 

## Persisting timers

If we want to persist the time elapsed between sessions,
we need a way to persist each `timer` 
(duration between a starting and stopping stopwatch at a time)
on the local device. 
For this,
we are going to be using [`drift`](https://drift.simonbinder.eu/),
which allows relational persistence inside our device.

The following steps follow [their docs](https://drift.simonbinder.eu/docs/getting-started/),
adapted to our scenario. 
If you get stuck, 
follow their documentation
and you'll find the right path straight away!

Let's first add the needed dependencies.
Head over to the `pubspec.yml` 
and add the following dependencies.

```yml
dependencies:
  drift: ^2.2.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.0.0
  path: ^1.8.2

dev_dependencies:
  drift_dev: ^2.2.0+1
  build_runner: ^2.2.1
```

and then run the following command
to fetch the dependencies.

```sh
flutter pub get
```

Now that everything is installed,
we are ready to start declaring our 
relational schema and database tables.
For this, 
create a file called `database.dart`
and paste the following code.

```dart
import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// This will generate a table called "Timers". 
// The rows of the table will be represented by a class called "Timer"
class Timers extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get stop => dateTime().nullable()();
}

// This annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Timers])
class MyDatabase extends _$MyDatabase {
}
```

In this file we define the `Timers` table,
which has three columns:
- `id`: an auto-incremented index.
- `start`: datetime object referring to the start of the timer
- `stop`: datetime object referring to the end of the timer. 
It can be `null` 
because the timer is created 
with this field being `null` 
which is then updated after it is stopped.

Additionally, 
with the `@DriftDatabase` annotation
we add an array of the tables we want to create.

We now need to generate the needed files
to import in the app to access the database.
For this, 
using the configuration file `database.dart` we just created,
we generate the code.

Run `flutter pub run build_runner build` 
and you will notice a `database.g.dart` file was created.
To use this file, 
change the `MyDatabase` class
defined in the `database.dart` file defined earlier.

```dart
@DriftDatabase(tables: [Timers])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
```

And now we are ready to use our `MyDatabase`
instance in our app!

> The database class created is ready to be used.
> However, in Flutter app, `Drift` database classes 
> are typically instantiated at the top of the widget tree
> and then passed down using state management tools,
> like `provider` or `riverpod`,
> making it accessible on any widget inside the tree.
> If you are interested, 
> check the following page
> for information about state management integration
> -> https://drift.simonbinder.eu/faq/#using-the-database

You can check if the database is accessible
by switching the `main` function 
to the following piece of code,
inside the `main.lib`.

```dart
import 'database.dart' as Db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = Db.MyDatabase();

  // Simple select:
  final allTimers = await database.select(database.timers).get();
  print('Timers in database: $allTimers');

  runApp(MyApp());
}
```

It is really important to import `database.dart` as `Db`.
This is because we created a `Timer` class, 
which can conflict with Dart's native 
[`Timer`](https://api.dart.dev/stable/2.18.4/dart-async/Timer-class.html) class.

If you run the app, 
you should see the following in the terminal.

```
flutter: Timers in database: []
```

## Creating and updating timers
Let's insert a row inside the `Timer` table
everytime the stopwatch is started
and update the `stop` field everytime
the stopwatch is stopped.

Inside the `main.dart` file,
update the code so it looks like the following.


```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

import 'database.dart' as Db;
import 'utils.dart';

main() {
  runApp(MyApp());
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
          ],
        ),
      ),
    );
  }
}
```

Inside the `_StopwatchPageState` state widget,
we are going to be adding two new fields.
- `_database`: a `MyDatabase` Drift database instance.
- `currentId`: the current ID of the timer that is occuring
while running the stopwatch.
This refers to the `id` column of the `Timer` table.

These variables are initialized 
inside the `initState()`.
This function is called *just a single time*, 
on widget mount. 
Inside this function,
we use `WidgetsFlutterBinding.ensureInitialized()` 
to make sure that everything is initialized.
You can learn more about why you need this
[if you check their docs, in the "Next Steps" section](https://drift.simonbinder.eu/docs/getting-started/#next-steps).

We are changing the `handleStartStop()` function
to properly interact with the database 
depending if the stopwatch is running or not.
If the stopwatch was started,
we insert a new timer in the table.

```dart
final insertedId = await _database
          .into(_database.timers)
          .insert(Db.TimersCompanion.insert(start: DateTime.now()));
```

As you can see from the previous snippet,
we are using the generated class `TimersCompanion`,
which has a constructor that is used to create objects
and insert in the database.
If the column is nullable or has a default value 
(like, for example, the `id` that auto-increments),
the field can be ommited. 
All others must be set.

After inserting, 
we update the state of the widget
to update the `currentId` with the one 
that was inserted in the database.

On the other hand, 
if the stopwatch is already running
and the user wants to stop, 
we update the current timer
`stop` field in the database. 
For this,
we create a `TimersCompanion` 
with a `stop` value (using Drift's class `Value`)
and then use it when updating the databse.

```dart
(_database.update(_database.timers)
            ..where((tbl) => tbl.id.equals(currentId)))
          .write(updatedTimer);
```

To update, 
we use the `currentId` in the widget state
and update the row using the `write()` function.

At the end of the flow, 
we rerender the UI wdiget
by calling `setState((){})`. 
This is needed 
or else the stopwatch won't properly stop.

## Deleting all timers
It would be nice to have a button 
that would delete all the timers. 
Let's do that.

Inside the `main.dart` file, 
in the `build` function, 
add an `ElevatedButton`, so it look likes this.

```dart
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
```

This button is calling a function when pressed.
Let's implement it 🙂.

```dart
  // Deletes all timers
  Future<void> deleteHistoricTimers() async {
    _database.delete(_database.timers).go();
  }
```

As you can see, 
it's fairly simple. 
This function just accesses the database 
and deletes the all the timers inside the `Timer` table.

If you want to check if the deleting is working,
uncomment the lines inside the `handleStartStop()`
function.

```dart
//final allTimers = await _database.select(_database.timers).get();
//print(allTimers);
```

and run the app. It should look like this.

<img width="600" alt="deleting" src="https://user-images.githubusercontent.com/17494745/202709192-9bad053e-e562-4777-9ad3-eec5286c2c98.png">

If you start and stop a few times, 
you will see the `incrementId` increase 
and see the  the terminal logging the `Timers` database table
everytime you stop the stopwatch.

```
flutter: [Timer(id: 46, start: 2022-11-18 12:49:33.000, stop: 2022-11-18 12:49:35.000)]
```

If you press `Delete` and start and stop the stopwatch,
you will see that the array will only have a single Timer.
This means that deleting is properly working!

## Persisting between sessions and extending stopwatch capabilities
As it stands, 
we are not making use of the timers we are persisting. 
This is because the Dart's SDK `Stopwatch` class
is too simple for what we want. 
It can start and stop in a session just fine 
but it doesn't maintain its value between sessions 
(e.g. closing and reopining the app).

Therefore, 
we need to *extend* the `Stopwatch` class
to be able to have this requirement.
When mounting the app, 
we can fetch the persisted timers
and see how much time has already elapsed.
Therefore, 
we need to initialize a `Stopwatch` object
with an initial elapsed time. 
With this in mind, 
let's create a class that 
_wraps_ the `Stopwatch` class and adds an 
`initialOffset` that we can add to it. 
We are going to override the `isRunning`, `elapsed` 
and `elapsedMiliseconds` functions 

Create a file called `stopwatch.dart` file
and add the following code to it.

```dart
class StopwatchEx {
  final Stopwatch _stopWatch = Stopwatch();
  Duration _initialOffset;

  StopwatchEx({Duration initialOffset = Duration.zero})
      : _initialOffset = initialOffset;

  start() => _stopWatch.start();

  stop() => _stopWatch.stop();

  reset({Duration? newInitialOffset}) {
    _stopWatch.reset();
    _initialOffset = newInitialOffset ?? const Duration();
  }

  bool get isRunning => _stopWatch.isRunning;

  Duration get elapsed => _stopWatch.elapsed + _initialOffset;

  int get elapsedMilliseconds =>
      _stopWatch.elapsedMilliseconds + _initialOffset.inMilliseconds;
}
```

Inside the `main.dart` file, 
change it so it looks like the following.

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:stopwatch_demo/stopwatch.dart';

import 'database.dart' as Db;
import 'utils.dart';

main() {
  runApp(MyApp());
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
```

Let's do a rundown on the changes applied.
The `_stopwatch` field is now using the `StopwatchEx` class,
which is our wrapped class. 
When initializing the variables inside the page,
we want our `_stopwatch` field to *not* start from scratch
but from a time that was previously stopped.
This is why we persist the timers.
Therefore, 
to initialize the `_stopwatch`, 
we need to access the database and fetch the timers
to see how much time it has elapsed. 
This is an [*asynchronous* operation](https://dart.dev/codelabs/async-await), 
meaning that the `_stopwatch` field 
has to be wrapped in a [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html) class.

To initialize the `_stopwatch` field, 
we create an `initializeStopwatch()` function 
that is called in `initState()`.
Inside the `initializeStopwatch()` function,
we fetch all the timers inside the database
and get cumulative duration elapsed. 
This value will be used when instantiating a
`StopwatchEx` class,
that is created with this initial offset.

Another change that was applied 
relates to deleting timers.
Now, when deleting timers, 
the stopwatch is reset.

Additionally, 
since `_stopwatch` is a `Future` field,
everytime it is needs to be accessed, 
we have to use `await`. 
This is what happens in `handleStartStop()`.

Lastly, in the `build` function, 
we make use of the [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) widget. 
As the name implies, 
it's a widget made to handle async data operations.
The UI is rendered according to the result
of these async operations.

The changes made follow the following template.

```dart
FutureBuilder<StopwatchEx>(
  future: _stopwatch,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },
)
```

We've added two `FloatingActionButton`, 
one to toggle between "Start" and "Stop" 
and another one to reset the stopwatch 
(and deleting the persisted timers, as well).

Congratulations, 
your app now allows you 
to start and stop the stopwatch and
maintain the elapsed time even if you
closed and reopened the app 
(thanks to persisting the timers inside the `Drift` database)
🎉.

Your app should now look like this.

<img width="600" alt="persisting" src="https://user-images.githubusercontent.com/17494745/202722175-07ecc495-bb9a-41ab-81c9-363045cd2a80.png">

## Adding a page to see persisted timers
Wouldn't it be nice to have a page 
where we could see the timers that are currently
in the database? 
We fancy it would 😉.

Let's do it.

Inside the `build` function function, 
in the `appBar` property, 
change it to the following snipet of code.
This will add an `IconButton` that,
when pressed, 
it will navigate the user
to another page showing a list of the persisted timers.

```dart
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
```

As you can see, 
when pressed, 
a `_pushCompleted` function is called. 
Let's implement it.

```dart
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
```

In this function, 
we are fetching
all the timers inside the `Timer` table of
the Drift database.
After fetching all the timers,
we use the [`Navigator`](https://docs.flutter.dev/development/ui/navigation)
class to navigate to a route.
In this same function, 
we define the route.
It will hold a `ListView` 
consisting of an array of `ListTile`s. 
In each `ListTile`,
we merely print the `Timer` information - 
the `id`, `start` and `stop` fields.

If we try to run the app now, 
it's likely an error stating 
`There are multiple heroes that share the same tag within a subtree.`
is thrown.
To fix this, 
simply add a `heroTag` property
to each `FloatingActionButton` 
inside the `build` function
inside `_StopwatchPageState` widget state class.

Here's how our `build` function was changed to.

```dart
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
```

If we run the app now, 
it should work properly! 👏
You will find a button on the right side of the appbar.
If you click it, 
you will see a list of the current
timers that are persisted inside the database.

<img width="600" alt="final" src="https://user-images.githubusercontent.com/17494745/202734558-8497a442-6ff4-4007-83d6-764a878b7f15.png">

## Quick code cleanup

Let's just clean our code a little bit.
The `MyApp` class is not really necessary here.
Let's delete it and call the `StopwatchPage` class
directly from the `main()` function.

```dart
main() {
  runApp(const MaterialApp(title: 'Stopwatch Example', home: StopwatchPage()));
}
```

That is it!
Your application should now work properly!
Congratulations! 🎉

You just created not only a simple stopwatch application
but also learnt about how to leverage
the `Drift` database to create a local database
and save information on your device
*and* use this information to 
maintain the application state across sessions. 

Awesome job!

Your `main.dart` should look 
[similar to this repo's code](https://github.com/dwyl/flutter-stopwatch-tutorial/blob/initial-implementation/lib/main.dart).

# What's next? 🤨
If you found this walkthrough useful, 
don't be afraid to star the repo so we know 
we're doing something right.

Your feedback is always welcome!
If you think there's an error 
or if something's not working, 
do [open an issue](https://github.com/dwyl/flutter-stopwatch-tutorial/issues)
and let's discuss!
