
// import 'package:flutter/material.dart';
// import 'dart:ffi';

// import 'package:gamers_grotto/objects/Player.dart';

// class GameScreen extends StatefulWidget{
//   GameScreen({
//     super.key,
//     required this.players,
//     required this.mainX,
//     required this.mainY
//   });

//   List<Player> players;
//   List<Widget> _players = [];
//   double mainX;
//   double mainY;
//   @override
//   State<StatefulWidget> createState() => GameScreenState();
// }

// class GameScreenState extends State<GameScreen> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           onTapDown: (details) {
//             widget.mainX = details.globalPosition.dx;
//             widget.mainY = details.globalPosition.dy;
//           },
//           child: Container(
//             child: Stack(
//             )
//           )
//         )
//       );
//   }
// }
