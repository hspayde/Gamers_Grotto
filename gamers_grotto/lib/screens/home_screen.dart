import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gamers_grotto/widgets.dart';

import 'game_page.dart';

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
      body: 
      Stack(
        children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/pexels-feiwang-15837757.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
        ), // I decided it looked better without the image in the background
        Padding(
          padding: const EdgeInsets.all(20),
          child:
          Align(
            alignment: Alignment.center,
            child:
              SingleChildScrollView(
                child:
                Column(
                  children: <Widget> [
                    const MainTitleText(),
                    Text("Welcome to the Grotto, please type your name and choose a color!", 
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 20),),
                    TextField(
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary
                      ),
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          nameVal = value;
                        });
                      },
                      decoration: const InputDecoration(hintText: "Input your display name here"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child:
                      ColorPicker(
                        pickerColor: Colors.black, 
                        
                        onColorChanged: (value) {
                          colorVal = value.toHexString();
                        }
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).colorScheme.onSecondary,
                      onPressed: () { 
                        if(nameVal != "") {
                          //widget.onPlayerAdded(nameVal, colorVal);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const GamePage(),
                            )
                          );
                        }else {
                          null;
                        }
                      },
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ]),
    );
  }
}