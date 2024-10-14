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
      .collection('players')
      .snapshots()
      .listen((snapshot) {
        _players = [];
        for(final playerInfo in snapshot.docs) {
          _players.add(
            Player(
              name: playerInfo.data()['name'] as String,
              x: double.parse(playerInfo.data()['goalPosX'].toString()), 
              y: double.parse(playerInfo.data()['goalPosY'].toString()),
              color: playerInfo.data()['color'] as String
            ),
          );
        }
      });
  }

  Future<void> addPlayer(Player newPlayer) {
    Map<String, dynamic> data = <String, dynamic>{
      'name' : newPlayer.name,
      'goalPosX' :  newPlayer.goalX,
      'goalPosY' : newPlayer.goalY,
      'color' : "red"
    };
    return FirebaseFirestore.instance
      .collection('players')
      .doc(newPlayer.name)
      .set(data);
  }

  void removePlayer(String playerName) {
          FirebaseFirestore.instance
          .collection('players')
          .doc(playerName)
          .delete();

  }


}