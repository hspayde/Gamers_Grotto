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

  Map<String, Player> players = {};
  List<String> messages = [];
  Player currentPlayer =
      Player(name: "Template", x: 50.0, y: 50.0, color: "FF000000");

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print("Initializing Firebase");
    FirebaseFirestore.instance
        .collection('rooms')
        .doc('mainroom')
        .collection('players');
    FirebaseFirestore.instance
        .collection('rooms')
        .doc('mainroom')
        .collection('messages');

    FirebaseFirestore.instance
        .collection('rooms')
        .doc('mainroom')
        .collection('messages')
        .orderBy("timestamp")
        .snapshots()
        .listen((snapshot) {
      messages = [];
      for (final message in snapshot.docs) {
        messages.add(message["value"]);
      }

      notifyListeners();
    });

    FirebaseFirestore.instance
        .collection('rooms')
        .doc('mainroom')
        .collection('players')
        .snapshots()
        .listen((snapshot) {
      players = {};
      for (final playerInfo in snapshot.docs) {
        String playerName = playerInfo.data()['name'];
        currentPlayer = Player(
          name: playerInfo.data()['name'] as String,
          x: double.parse(playerInfo.data()['posX'].toString()),
          y: double.parse(playerInfo.data()['posY'].toString()),
          color: playerInfo.data()['color'] as String,
          message: playerInfo.data()['message'] as String,
        );
        players[playerName] = currentPlayer;
      }

      notifyListeners();
    });
  }

  void addPlayer(Player newPlayer, String room) {
    Map<String, dynamic> data = <String, dynamic>{
      'name': newPlayer.name,
      'posX': newPlayer.x,
      'posY': newPlayer.y,
      'color': newPlayer.color,
      'message': newPlayer.message
    };
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('players')
        .doc(newPlayer.name)
        .set(data);
  }

  void addMessage(String room, String message, String playerName) {
    var data = {
      "value": (playerName + ": " + message),
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('messages')
        .doc()
        .set(data);
  }

  void updateMessage(String room, String message, String playerName) {
    print("Player " + playerName + " Has said " + message);
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('players')
        .doc(playerName)
        .update({'message': message});
  }

  void switchPlayer(String newRoom, String oldRoom, String playerName) {
    Player player = players[playerName]!;
    print(player);
    removePlayer(oldRoom, playerName);
    addPlayer(player, newRoom);
  }

  void removePlayer(String room, String playerName) {
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('players')
        .doc(playerName)
        .delete();
  }

  void setPlayerPos(String room, String playerName, double x, double y) {
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('players')
        .doc(playerName)
        .update({'posX': x, 'posY': y});
  }

  void addToChat(String room, String message, Player p) {
    p.message = message;
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('players')
        .doc(p.name)
        .update({'message': message});
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(room)
        .collection('chatlog')
        .add(<String, dynamic>{
      'text': '${p.name}: $message',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': p.name,
    });
  }
}
