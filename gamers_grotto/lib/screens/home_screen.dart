import 'package:flutter/material.dart';
import 'package:gamers_grotto/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const TitleText(),
      ),
      body: const Column(
        children: <Widget>[
          
        ]
      )
    );
  }
}