import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navigatetab extends StatefulWidget {
  final Image logo;
  final String name;
  const Navigatetab({super.key,
  required this.logo,
  required this.name,
  });

  @override
  State<Navigatetab> createState() => _NavigatetabState();
}

class _NavigatetabState extends State<Navigatetab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(14),
          ),
          child: widget.logo
          ,
        ),
        Text(
          widget.name,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
        )
      ],
    );
  }
}
