// import 'dart: async';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'objects/Player.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }


  List<Player> _players = [];
  List<Player> get players => _players;
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print("Initializing Firebase");
    FirebaseFirestore.instance
      .collection('rooms')
      .doc('main room')
      .collection('players')
      .snapshots()
      .listen((snapshot) {
        _players = [];
        for(final playerInfo in snapshot.docs) {
          _players.add(
            Player(
              name: playerInfo.data()['name'] as String,
              x: double.parse(playerInfo.data()['posX'].toString()), 
              y: double.parse(playerInfo.data()['posY'].toString()),
              color: playerInfo.data()['color'] as String
            ),
          );
        }
      });
  }

  Future<void> addPlayer(Player newPlayer, String room) {
    Map<String, dynamic> data = <String, dynamic>{
      'name' : newPlayer.name,
      'posX' :  newPlayer.goalX,
      'posY' : newPlayer.goalY,
      'color' : newPlayer.color
    };
    return FirebaseFirestore.instance
      .collection('rooms')
      .doc(room)
      .collection('players')
      .doc(newPlayer.name)
      .set(data);
  }

  void removePlayer(String room, String playerName) {
          FirebaseFirestore.instance
          .collection('rooms')
          .doc(room)
          .collection('players')
          .doc(playerName)
          .delete();
  }

  Future<void> addToChat(String room, String message, Player p) {
    return FirebaseFirestore.instance
      .collection('rooms')
      .doc(room)
      .collection('chatlog')
      .add(<String, dynamic>{
    'text': message,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
    'name': p.name,
    });
  }

}