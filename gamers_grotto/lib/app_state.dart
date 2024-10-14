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

  Future<DocumentReference> addPlayer(Player newPlayer) {
    print("Adding Player");
    return FirebaseFirestore.instance
          .collection('players')
          .add(<String, dynamic> {
            'name' : "Hello",
            'goalPosX' : 10.0,
            'goalPosY' : 10.0,
            'color' : "red",
            'latestMessage' : "Hello"
          });
  }

  // void removePlayer(String playerName) {
  //         FirebaseFirestore.instance
  //         .collection('players')
  //         .
  //         .

  // }


}