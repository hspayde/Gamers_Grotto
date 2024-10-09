
import 'package:flutter/material.dart';

class Player {
  Player({required this.x, required this.y, required this.color});

  double x;
  double y;
  late double goalX = x;
  late double goalY = y;
  Color color = Colors.red;
}