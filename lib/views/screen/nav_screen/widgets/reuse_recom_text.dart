import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReuseRecomText extends StatelessWidget {
  const ReuseRecomText(
      {super.key, required this.tittle, required this.subTittle});
  final String tittle;
  final String subTittle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          subTittle,
          style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
