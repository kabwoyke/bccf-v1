import 'package:bccf/components/navigater.dart';
import 'package:bccf/components/notification.dart';
import 'package:bccf/components/word.dart';
import 'package:bccf/main.dart';
import 'package:bccf/screens/events.dart';
import 'package:bccf/screens/login.dart';
import 'package:bccf/screens/prayer.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        backgroundColor: Colors.grey.shade200,
        toolbarHeight: 50,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              child: Image(image: AssetImage("assets/logo.jpeg")),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "The BCCF APP",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        actions: [
          NotificationIcon(icon: Icons.notifications, counter: 5),
          const SizedBox(width: 10,),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder:(BuildContext context) =>[
               PopupMenuItem(child:ListTile(
                leading:Icon(Icons.person),
                title: Text("Kimani"),
                onTap:(){},
              )),
              PopupMenuItem(child:ListTile(
                leading:Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                        try{
                          await supabase.auth.signOut();
                        } on AuthException catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${e.message}"))
                          );
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${e}"))
                          );
                        }
                        print("logged out");
                      },
              )),
            ]
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Word(),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                 children: [
                  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Navigatetab(onPressed: (){}, logo: Image.asset("assets/Church.jpg"), name: "Services"),
                SizedBox(width: 10,),
                Navigatetab(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Events()));}, logo: Image.asset("assets/calender.png"), name: "Events"),
                SizedBox(width: 10,),
                Navigatetab(onPressed: (){},logo: Image.asset("assets/Giving.jpg"), name: "Offering"),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigatetab(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Prayerpage()));},logo: Image.asset("assets/Prayer.jpg"), name: "Prayer Request"),
                SizedBox(width: 10,),
                Navigatetab(onPressed: (){}, logo: Image.asset("assets/Projects.jpg"), name: "Projects"),
                SizedBox(width: 10,),
                Navigatetab(onPressed:(){}, logo: Image.asset("assets/Social.png"), name: "Our Socials"),

                 ],
            )
                 ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
