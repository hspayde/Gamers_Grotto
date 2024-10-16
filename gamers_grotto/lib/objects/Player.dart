
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Player {
  Player({required this.name, required this.x, required this.y, required this.color, this.message = ''});
  String name;
  double x;
  double y;
  String color;
  String message;

  Color strColor(){
    if(colorFromHex(color) != null) {
      return colorFromHex(color)!;
    } else {
      return Colors.black;
    }
  }
  String toString() {
    return this.name;
  }
}