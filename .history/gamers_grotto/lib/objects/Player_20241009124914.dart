
import 'package:flutter/material.dart';

class Player {
  Player({required this.name, required this.x, required this.y, required this.color, this.message = ''});
  String name;
  double x;
  double y;
  late double goalX = x;
  late double goalY = y;
  Color color = Colors.red;
  String message;
}