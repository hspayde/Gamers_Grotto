
import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:gamers_grotto/objects/Player.dart';

import 'package:flutter/widgets.dart';
import 'package:gamers_grotto/widgets.dart';

typedef movePlayer = Function(double x, double y);
class GameScreen extends StatefulWidget{
  GameScreen({
    super.key,
    required this.players,
    required this.doMove
  });
  movePlayer doMove;
  Map<String, Player> players;
  List<Widget> _players = [];
  @override
  State<StatefulWidget> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  double x = 0;
  double y = 0;
  List<Widget> getPlayerWidgets() {
    List<Widget> finalList = [];
    for (var element in widget.players.values) {
      finalList.add(PlayerAvatar(element.name, element.message, element.strColor(), element.x, element.y));
    }
    return finalList;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (details) {
            widget.doMove(details.globalPosition.dx, details.globalPosition.dy);
          },
          child: Container(
            child: Stack(
              children: getPlayerWidgets(),
            )
          )
        )
      );
  }
}
