import 'package:flutter/material.dart';
import 'package:gamers_grotto/app_state.dart';
import 'objects/Player.dart';
import 'package:gamers_grotto/widgets.dart';
import 'package:gamers_grotto/screens/home_screen.dart';
import 'screens/home_screen.dart';

void main() {
  ThemeData theme = ThemeData(colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 106, 112, 89),
          onPrimary: Color.fromARGB(255, 253, 238, 167),
          secondary: Color.fromARGB(255, 155, 204, 167),
          onSecondary: Color.fromARGB(255,0, 41, 61),
          tertiary: Color.fromARGB(255, 5, 69, 87),
          onTertiary: Color.fromARGB(255, 253, 238, 167),
          error: Color.fromARGB(255, 188, 124, 124),
          onError: Color.fromARGB(255, 246, 239, 189),
          surface: Color.fromARGB(255, 165, 182, 141),
          onSurface: Color.fromARGB(255,0, 41, 61),
        ),);
  runApp(MaterialApp(home: const HomeScreen(), theme: theme));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ApplicationState appState = ApplicationState();
  Player newPlayer = Player(x: 10.0,y:10.0, color: "green", name: "Hello");
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      appState.addPlayer(newPlayer);
      _counter++;
    });
  }

  void createPlayer(String playerName, String colorHex) {
    Player newPlayer = Player(x: 10.0, y:10.0, color : colorHex, name:playerName);
    appState.addPlayer(newPlayer);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          appState.players.toString()
          ),
      ),
      body: HomeScreen(onPlayerAdded: createPlayer
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
