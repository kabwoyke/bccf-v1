import 'package:bccf/components/navigater.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Image.asset("assets/logo.jpeg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          "Welcome To BCCF app",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 0.5, endIndent: 1),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          greatings(),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Kimani",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.info),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Icon(
                                  Icons.notifications,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 40,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Word Of The Day",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Divider(thickness: 2),
                        Text(
                          "2 Chronicles 7:14",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "If my people who are called by My name humble themselves, and pray and seek My face and turn from their wicked ways, then I will hear from heaven and will forgive their sin and heal their land.",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Navigatetab(
                          logo: Image(image: AssetImage("assets/logo.jpeg")),
                          name: "Home",
                        ),
                        Navigatetab(
                          logo: Image(image: AssetImage("assets/logo.jpeg")),
                          name: "Home",
                        ),
                        Navigatetab(
                          logo: Image(image: AssetImage("assets/logo.jpeg")),
                          name: "Home",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Navigatetab(
                      logo: Image(image: AssetImage("assets/logo.jpeg")),
                      name: "Home",
                    ),
                    Navigatetab(
                      logo: Image(image: AssetImage("assets/logo.jpeg")),
                      name: "Home",
                    ),
                    Navigatetab(
                      logo: Image(image: AssetImage("assets/logo.jpeg")),
                      name: "Home",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
);

  }
}