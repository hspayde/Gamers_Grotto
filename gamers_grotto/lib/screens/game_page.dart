import 'package:flutter/material.dart';

import '../widgets.dart';

class GamePage extends StatefulWidget{
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {


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
            onPressed: () { Navigator.pop(context);},
            icon: Icon(Icons.home_filled, color: Theme.of(context).colorScheme.secondary),
            ),
        ],
      ),
    );
  }
}