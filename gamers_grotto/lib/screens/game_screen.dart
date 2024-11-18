import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:gamers_grotto/objects/Player.dart';

import 'package:flutter/widgets.dart';
import 'package:gamers_grotto/widgets.dart';

typedef movePlayer = Function(double x, double y);

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.players, required this.doMove});
  movePlayer doMove;
  List<Widget> players = [];
  @override
  State<StatefulWidget> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  double x = 0;
  double y = 0;
  void empty(x, y) {}
  @override
  void dispose() {
    super.dispose();
    widget.doMove = empty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (details) {
              widget.doMove(
                  details.globalPosition.dx, details.globalPosition.dy);
            },
            child: Container(
                child: Stack(
              children: widget.players,
            ))));
  }
}
