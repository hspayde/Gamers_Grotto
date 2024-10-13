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

    FirebaseFirestore.instance.collection("test").doc("Hello!");
    FirebaseFirestore.instance
      .collection('players')
      .snapshots()
      .listen((snapshot) {
        _players = [];
        for(final playerInfo in snapshot.docs) {
          _players.add(
            Player(
              name: playerInfo.data()['name'] as String,
              x: playerInfo.data()['goalPosX'] as double, 
              y: playerInfo.data()['goalPosY'] as double,
              color: playerInfo.data()['color'] as Color
            ),
          );
        }
      });
  }

  Future<DocumentReference> addPlayer(Player newPlayer) {
    return FirebaseFirestore.instance
          .collection('players')
          .add(<String, dynamic> {
            'name' : newPlayer.name,
            'goalPosX' : newPlayer.goalX,
            'goalPosY' : newPlayer.goalY,
            'color' : newPlayer.color,
            'latestMessage' : newPlayer.message
          });
  }

  // void removePlayer(String playerName) {
  //         FirebaseFirestore.instance
  //         .collection('players')
  //         .
  //         .

  // }


}