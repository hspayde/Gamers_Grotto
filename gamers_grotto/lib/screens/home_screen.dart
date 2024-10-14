import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

typedef playerAdded = Function(String name, String color);

class HomeScreen extends StatefulWidget{
  const HomeScreen({
    super.key,
    required this.onPlayerAdded,
  });

  final playerAdded onPlayerAdded;
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();

  String nameVal = "";
  String colorVal = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gamers Grotto")
      ),
      body: Column(
        children: [
          const Text("Welcome to the Grotto, please type your name and choose a color!"),
          TextField(
            controller: nameController,
            onChanged: (value) {
              setState(() {
                nameVal = value;
              });
            },
            decoration: const InputDecoration(hintText: "Input your display name here"),
          ),
          ColorPicker(
            pickerColor: Colors.black, 
            onColorChanged: (value) {
              colorVal = value.toHexString();
            }
          ),
          FloatingActionButton(
            onPressed: () { 
              widget.onPlayerAdded(nameVal, colorVal);
            }
          )
        ],
      ),
    );
  }
}