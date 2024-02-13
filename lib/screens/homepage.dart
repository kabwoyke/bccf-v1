import 'package:bccf/components/navigater.dart';
import 'package:bccf/components/notification.dart';
import 'package:bccf/components/word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String greatings() {
    final current = DateTime.now();
    final _hour = current.hour;
    if (_hour < 12) {
      return "Good Morning,";
    } else if (_hour < 18) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey.shade300,
        backgroundColor: Colors.blue.shade300,
        toolbarHeight: 70,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Center(
          child: Column(
            children: [
              Container(
                height: 40,
                child: Image(image: AssetImage("assets/logo.jpeg")),
              ),
              Text(
                "The BCCF APP",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              NotificationIcon(icon: Icons.notifications, counter: 5),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  greatings(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Kimani",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Word(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigatetab(logo: Image.asset("assets/logo.jpeg"), name: "home"),
                Navigatetab(logo: Image.asset("assets/logo.jpeg"), name: "home"),
                Navigatetab(logo: Image.asset("assets/logo.jpeg"), name: "home"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigatetab(logo: Image.asset("assets/logo.jpeg"), name: "home"),
                Navigatetab(logo: Image.asset("assets/logo.jpeg"), name: "home"),
                Navigatetab(logo: Image.asset("assets/logo.jpeg"), name: "home"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
