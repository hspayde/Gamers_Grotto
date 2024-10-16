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
