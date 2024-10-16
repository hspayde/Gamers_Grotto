import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamers_grotto/screens/game_screen.dart';
import '../app_state.dart';
import '../widgets.dart';
import '../objects/Player.dart';
import 'dart:math';

typedef removePlayer = Function();

class GamePage extends StatefulWidget{
  GamePage({super.key, required this.onPlayerRemoved, required this.appState, required this.playerName});

  final removePlayer onPlayerRemoved;
  final ApplicationState appState;
  final String playerName;
  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  double playerTargetX = 0;
  double playerTargetY = 0;
  double moveSpeed = 15;
  void movePlayer() {
    try {
      setState(() {
      print("Moving");
      Map<String, Player> players = widget.appState.getPlayers();
      Player? localPlayer = players[widget.playerName];
      double difX = localPlayer!.x - playerTargetX;
      double difY = localPlayer.y - playerTargetY;
      double totalDif = difY.abs() + difX.abs();
      double moveX = -1 *(difX/totalDif) * moveSpeed;
      double moveY = -1 *(difY/totalDif) * moveSpeed;
      double newX = moveX + localPlayer.x;
      double newY = moveY + localPlayer.y;
      widget.appState.setPlayerPos(widget.playerName, newX, newY);
    });
    } catch (_) {

    }
  }

  late Timer timer;
  void setTarget(double x, double y) { 
    playerTargetX = x;
    playerTargetY = y;
  }

  Map<String, Player> getPlayers() {
    return widget.appState.getPlayers();
  }
  @override
  Widget build(BuildContext context) {
    timer = Timer(Duration(milliseconds: 100), movePlayer);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: const TitleText(),
        actions: [
          IconButton(
            onPressed: () { 
              widget.onPlayerRemoved();
              Navigator.pop(context);
            },
            icon: Icon(Icons.home_filled, color: Theme.of(context).colorScheme.secondary),
            ),
        ],
      ),
      body: GameScreen(players: getPlayers(), doMove: setTarget),
    );
  }
}