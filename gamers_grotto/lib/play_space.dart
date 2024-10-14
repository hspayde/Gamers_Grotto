// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'objects/Player.dart';

// class PlaySpace extends StatefulWidget{
//     const PlaySpace({
//     super.key, 
//     required this.addPlayer, 
//     required this.players,

//   });

//   final FutureOr<void> Function(double x, double y, Color color) addPlayer;

//   final List<Player> players;

//   @override
//   State<StatefulWidget> createState() => 

// }

// class _PlaySpaceState extends State<PlaySpace> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_PlaySpaceState');
//   double x = 0;
//   double y = 0;
//   @override
//   Widget build(BuildContext context) {
//       return Center(
//         child: GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           onTapDown: (details) {

//             x = details.globalPosition.dx;
//             y = details.globalPosition.dy;
//           },
//           child: Container(
//             child: Stack(
//               children: players,
//             )
//           )
//         )
//       );
//   }
// }