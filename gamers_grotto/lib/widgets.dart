import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class MainTitleText extends StatelessWidget {
  const MainTitleText({super.key});
  final String titleText = "Gamer's Grotto";

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        titleText,
        style: GoogleFonts.sixtyfour(
            color: Theme.of(context).colorScheme.tertiary, fontSize: 25),
      ));
}

class TitleText extends StatelessWidget {
  const TitleText({super.key});
  final String titleText = "Gamer's Grotto";

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        titleText,
        style: GoogleFonts.sixtyfour(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),
      ));
}

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar(
      this.username, this.chatMessage, this.circColor, this.x, this.y,
      {super.key});
  final String username;
  final String chatMessage;
  final Color circColor;
  final double x;
  final double y;
  getMessage() {
    if (this.chatMessage != "") {
      print(this.chatMessage);
    }
    return this.chatMessage;
  }

  @override
  Widget build(BuildContext context) => Positioned(
      top: y - 50,
      left: x - 10,
      child: Column(
        children: <Widget>[
          Text(
            getMessage(),
            style: TextStyle(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                color: Theme.of(context).colorScheme.onSecondary),
          ),
          Text(
            username,
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
          CircleAvatar(
            backgroundColor: circColor,
            radius: 10,
          )
        ],
      ));
}

class RoomText extends StatelessWidget {
  const RoomText({required this.roomName, super.key});
  final String roomName;

  @override
  Widget build(BuildContext context) => Text(
        roomName,
        style: GoogleFonts.protestStrike(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 12),
      );
}

class ChatLogDialog extends StatelessWidget {
  const ChatLogDialog({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text('Chatlog'),
          content: SingleChildScrollView(
            child: Consumer<ApplicationState>(builder: (context, appState, _) {
              List<Widget> children = [];
              for (String s in appState.messages) {
                children.add(Text(s));
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children);
            }),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app, size: 50),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]);
}
