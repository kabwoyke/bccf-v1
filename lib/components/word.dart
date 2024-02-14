import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Word extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.purple.shade400,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -5,
                left: 0,
                child: Transform.rotate(
                  angle: 3.14159,
                  child: const Icon(
                    Icons.format_quote,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                bottom: -4, // Adjusted bottom position
                right: 0, // Adjusted right position
                child: Transform.rotate(
                  angle: 6.28318,
                  child: const Icon(
                    Icons.format_quote,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height:20),
                    Text("Word of The Day",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                    const Divider(thickness: 2),
                    Text(
                      "Romans 8:38-39",
                      style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                       color: Colors.white
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom:30, left: 10, right: 10 ),
                      child: Text(" For I am convinced that neither death nor life, neither angels nor demons, neither the present nor the future, nor any powers, neither height nor depth, nor anything else in all creation, will be able to separate us from the love of God that is in Christ Jesus our Lord.",
                      style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                       color: Colors.white
                      ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
