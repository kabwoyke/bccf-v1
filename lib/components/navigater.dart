import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navigatetab extends StatefulWidget {
  final Image logo;
  final String name;
  final VoidCallback onPressed;

  const Navigatetab({
    Key? key,
    required this.logo,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<Navigatetab> createState() => _NavigatetabState();
}

class _NavigatetabState extends State<Navigatetab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Column(
        children: [
          Container(
            height:80,
            width: MediaQuery.of(context).size.width * 0.8/3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(child: widget.logo),
          ),
          SizedBox(height: 8),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
