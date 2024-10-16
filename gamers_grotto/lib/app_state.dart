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


  Map<String, Player> _players = {};
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print("Initializing Firebase");
        FirebaseFirestore.instance
      .collection('players')
      .snapshots()
      .listen((snapshot) {
        for(final playerInfo in snapshot.docs) {
          String playerName = playerInfo.data()['name'];
          _players[playerName] = 
            Player(
              name: playerInfo.data()['name'] as String,
              x: double.parse(playerInfo.data()['posX'].toString()), 
              y: double.parse(playerInfo.data()['posY'].toString()),
              color: playerInfo.data()['color'] as String
            );
        }
      });
  }

  Future<void> addPlayer(Player newPlayer) {
    Map<String, dynamic> data = <String, dynamic>{
      'name' : newPlayer.name,
      'posX' :  newPlayer.x,
      'posY' : newPlayer.y,
      'color' : newPlayer.color
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

  Map<String, Player> getPlayers() {
    FirebaseFirestore.instance
      .collection('players')
      .snapshots()
      .listen((snapshot) {
        for(final playerInfo in snapshot.docs) {
          String playerName = playerInfo.data()['name'];
          _players[playerName] = 
            Player(
              name: playerInfo.data()['name'] as String,
              x: double.parse(playerInfo.data()['posX'].toString()), 
              y: double.parse(playerInfo.data()['posY'].toString()),
              color: playerInfo.data()['color'] as String
            );
        }
      });
    print("NEWPLAYERSBIATCEs");
    print(_players);
    print("NONEWPLAYERS");
    return _players;
  }

  void setPlayerPos(String playerName, double x, double y){
      FirebaseFirestore.instance
      .collection('players')
      .doc(playerName)
      .update({'posX' : x, 'posY' : y});
  }

}