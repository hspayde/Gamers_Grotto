import 'package:flutter/material.dart';
import 'package:gamers_grotto/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        key: const Key('hStack'),
        children: <Widget>[
          Text("Hello", style: TextStyle(color: Colors.white)),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/pexels-feiwang-15837757.jpg"), //
                fit: BoxFit.cover,
              ),
            ),
          ),
          
        ]
      )

    );
  }
}