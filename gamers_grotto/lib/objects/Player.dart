
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Player {
  Player({required this.name, required this.x, required this.y, required this.color, this.message = ''});
  String name;
  double x;
  double y;
  late double goalX = x;
  late double goalY = y;
  String color;
  String message;

  Color strColor(){
    return Color(int.parse(color, radix: 16));
  }
}