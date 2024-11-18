import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gamers_grotto/screens/game_screen.dart';
import '../app_state.dart';
import '../widgets.dart';
import '../objects/Player.dart';
import 'dart:math';

typedef removePlayer = Function();

typedef movePlayer = Function(String newRoom);

class GamePage extends StatefulWidget {
  GamePage(
      {super.key,
      required this.onPlayerRemoved,
      required this.appState,
      required this.playerName,
      required this.onPlayerMoved});

  final removePlayer onPlayerRemoved;
  final movePlayer onPlayerMoved;
  final ApplicationState appState;
  final String playerName;
  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  TextEditingController chatController = TextEditingController();

  Map<String, Map<String, double>> roomBounds = {
    "trollcorner": {"x1": 0.0, "y1": 100.0, "x2": 50.0, "y2": 200}
  };
  List<Map<String, double>> playerTarget = [
    {"x": 500.0, "y": 250.0}
  ];
  double moveSpeed = 15;
  String currentRoom = "mainroom";

  checkRoomCollision(double x, double y) {
    for (var element in roomBounds.entries) {
      var bounds = element.value;
      if (!(bounds["x1"]! > x ||
          bounds["y1"]! > y ||
          bounds["x2"]! < x ||
          bounds["y2"]! < y)) {
        return element.key;
      }
    }
    return null;
  }

  void movePlayer(Timer timer) {
    try {
      Map<String, Player> players =
          widget.appState.getPlayers(currentRoom, widget.playerName);
      Player? localPlayer = players[widget.playerName];
      double difX = localPlayer!.x - playerTarget[0]["x"]!;
      double difY = localPlayer.y - playerTarget[0]["y"]!;
      double totalDif = difY.abs() + difX.abs();
      if (totalDif >= moveSpeed) {
        double moveX = -1 * (difX / totalDif) * moveSpeed;
        double moveY = -1 * (difY / totalDif) * moveSpeed;
        double newX = moveX + localPlayer.x;
        double newY = moveY + localPlayer.y;
        String? newRoom = checkRoomCollision(newX, newY);
        if (newRoom == null) {
          widget.appState
              .setPlayerPos(currentRoom, widget.playerName, newX, newY);
        } else {
          currentRoom = newRoom;
          widget.onPlayerMoved(newRoom);
        }
      } else {
        playerTarget.removeAt(0);
      }
    } catch (_) {
      print("Error");
    }
  }

  void update(Timer) {
    setState(() {});
  }

  late Timer timer;
  late Timer uiTimer;
  String currentMessage = "";
  void setTarget(double x, double y) {
    playerTarget.add({"x": x, "y": y});
  }

  List<Widget> getPlayers() {
    var currentPlayers =
        widget.appState.getPlayers(currentRoom, widget.playerName);
    List<Widget> finalList = [
      Positioned(
          top: 100,
          child: Container(
              color: Colors.green,
              width: 50,
              height: 100,
              child: const Text("TrollGarden")))
    ];
    for (var element in currentPlayers.values) {
      finalList.add(PlayerAvatar(element.name, element.message,
          element.strColor(), element.x, element.y));
    }
    return finalList;
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), movePlayer);
    uiTimer = Timer.periodic(const Duration(milliseconds: 200), update);
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    uiTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: const TitleText(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ChatLogDialog(
                        chatLog: widget.appState.getMessages(currentRoom));
                  });
            },
            icon: Icon(Icons.chat,
                color: Theme.of(context).colorScheme.secondary),
          ),
          IconButton(
            onPressed: () {
              widget.onPlayerRemoved();
              Navigator.pop(context);
            },
            icon: Icon(Icons.home_filled,
                color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
      body: GameScreen(players: getPlayers(), doMove: setTarget),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: chatController,
                  decoration: const InputDecoration(
                    hintText: 'Type Message Here',
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  child: Text('Send Message!'),
                  onPressed: () {
                    currentMessage = chatController.text;
                    widget.appState.addMessage(
                        currentRoom, currentMessage, widget.playerName);
                    widget.appState.updateMessage(
                        currentRoom, currentMessage, widget.playerName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
