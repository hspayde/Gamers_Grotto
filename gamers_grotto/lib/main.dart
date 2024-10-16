import 'package:flutter/material.dart';
import 'package:gamers_grotto/app_state.dart';
import 'package:gamers_grotto/screens/game_page.dart';
import 'objects/Player.dart';
import 'package:gamers_grotto/widgets.dart';
import 'package:gamers_grotto/screens/home_screen.dart';
import 'screens/home_screen.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

typedef PlayerAdded = Function(String name, String color);

void main() {

  runApp(MyHomePage(title: 'Gamers Grotto'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(brightness: Brightness.dark,
          primary: Color.fromARGB(255, 106, 112, 89),
          onPrimary: Color.fromARGB(255, 253, 238, 167),
          secondary: Color.fromARGB(255, 155, 204, 167),
          onSecondary: Color.fromARGB(255,0, 41, 61),
          tertiary: Color.fromARGB(255, 5, 69, 87),
          onTertiary: Color.fromARGB(255, 253, 238, 167),
          error: Color.fromARGB(255, 188, 124, 124),
          onError: Color.fromARGB(255, 246, 239, 189),
          surface: Color.fromARGB(255, 165, 182, 141),
          onSurface: Color.fromARGB(255,0, 41, 61),),
        useMaterial3: true,
      ), 
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ApplicationState appState = ApplicationState();
  final double centerX = 50;
  final double centerY = 500;
  var rng = Random();
  String _playerName = '';
  String _currentRoom = '';
  // void _playGame() {
  //   appState.setPlayerPos(_playerName, 105.0, 500.0);
  // }

  void createPlayer(String playerName, String colorHex) {
    _playerName = playerName;
    _currentRoom = "mainroom";
    //print("PLAYER HAS " + playerName);
    double newX = centerX + ((rng.nextDouble() * 50)-25);
    double newY = centerY + ((rng.nextDouble() * 50)-25);
    Player newPlayer = Player(x: newX, y: newY, color : colorHex, name:playerName);
    appState.addPlayer(newPlayer, _currentRoom);
  }

  void removePlayer() {
    appState.removePlayer(_playerName, _currentRoom);
  }

  void movePlayer(String newRoom) {
    String oldRoom = _currentRoom;
    
    appState.switchPlayer(newRoom, oldRoom, _playerName);
    _currentRoom = newRoom;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        theme: ThemeData(colorScheme: const ColorScheme(
          brightness: Brightness.dark,
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
        ),),
      
      home:
      Scaffold(
        body:
          HomeScreen(onPlayerAdded: createPlayer, onPlayerRemoved: removePlayer, onPlayerMoved: movePlayer, appState: appState),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _playGame,
          //   backgroundColor: const Color.fromARGB(255, 155, 204, 167),
          //   foregroundColor: const Color.fromARGB(255,0, 41, 61),
          //   tooltip: 'Play',
          //   child: const Icon(Icons.play_arrow),
          // ),
      ),
    );
  }
}
