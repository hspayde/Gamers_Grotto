import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});
  final String titleText = "Gamer's Grotto";
  

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      titleText,
      style: GoogleFonts.sixtyfour(),
    )
  )
}