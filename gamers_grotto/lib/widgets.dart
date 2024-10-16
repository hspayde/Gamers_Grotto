import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  const PlayerAvatar(this.username, this.chatMessage, this.circColor, this.x, this.y, {super.key});
  final String username;
  final String chatMessage;
  final Color circColor;
  final double x;
  final double y;

  @override
  Widget build(BuildContext context) => Positioned(
          top: y,
          left: x,
          child: Column(
        children: <Widget>[
          Text(
            chatMessage,
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
    style: GoogleFonts.protestStrike(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12),
  );
}

class ChatLogDialog extends StatelessWidget {
  const ChatLogDialog({required this.chatLog, super.key});
  final List<String> chatLog;
  
  List<Widget> chatLogChange() {
    List<Widget> changedChatLog = [];
    for(int i = 0; i < chatLog.length; i++) {
      changedChatLog.add(Text(chatLog[i]));
    }
    return changedChatLog;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Chatlog'),
    content:
      SingleChildScrollView(
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: chatLogChange()),
      ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.exit_to_app,size: 50),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ]
  );
}