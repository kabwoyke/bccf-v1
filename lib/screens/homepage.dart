import 'package:bccf/components/appbar.dart';
import 'package:bccf/components/navigater.dart';
import 'package:bccf/components/word.dart';
import 'package:bccf/screens/events.dart';
import 'package:bccf/screens/prayer.dart';

import 'package:bccf/screens/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bccf/screens/profile.dart';
import 'package:bccf/screens/station.dart';
import 'package:bccf/services/cache/NotificationDatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void social() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Container(
              height: 80,
              width: 80,
              child: Image.asset("assets/logo.jpeg"),
            ),
            title: Text("Our social Media Platforms,", style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),),
            contentPadding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            content: Container(
              height: 190,
              width:double.maxFinite,
              child: Column(
                children: [
                   GestureDetector(
                      child: Card(
                        elevation: 3,
                            child: ListTile(
                              leading: Image.asset("assets/facebook logo.png"),
                              title: Text("Facebook",style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),),
                              subtitle: Text("Click To Join Our Facebook Page",style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),),
                            ),
                          )
                    ),
                    SizedBox(height: 10,),
                     GestureDetector(
                      child: Card(
                        elevation: 3,
                            child: ListTile(
                              leading: Container(height: 40, width: 80, child: Image.asset("assets/YouTubelogo.png")),
                              title: Text("YouTube", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),),
                              subtitle: Text("Click To Join our Youtube Channel", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),),
                            ),
                          )
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Close"))
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotificationDatabase>().fetchNotification();

  }

  @override
  Widget build(BuildContext context) {
    final announce = context.read<NotificationDatabase>().fetchNotification();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Custom_appbar()),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Word(),
            const SizedBox(height: 30),
            Container(

              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
              height: 40,
              child: Image(image: AssetImage("assets/logo.jpeg")),
            ),
            Text(
              "The BCCF APP",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
          // value.announcements.where((a) => a.read == false).length
        actions: [
          Row(
            children: [
              GestureDetector
                (
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NotificationScreen()));
                  },
                  child: Consumer<NotificationDatabase>(
                    builder: (context , value , child) {
                      return NotificationIcon(
                          icon: Icons.notifications,
                          counter: value.notificationCount
                      );
                    }
                  )
              ),
              SizedBox(width:10),
              Padding(
                padding: const EdgeInsets.only(top:15),
                child: Column(

                  children: [
                    Navigatetab(
                        onPressed: () {},
                        logo: Image.asset("assets/Church.jpg"),
                        name: "Services"),
                    SizedBox(
                      width: 10,
                    ),
                    Navigatetab(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Events()));
                        },
                        logo: Image.asset("assets/calender.png"),
                        name: "Events"),
                    SizedBox(
                      width: 10,
                    ),
                    Navigatetab(
                        onPressed: () {},
                        logo: Image.asset("assets/Giving.jpg"),
                        name: "Offering"),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Navigatetab(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Prayerpage()));
                        },
                        logo: Image.asset("assets/Prayer.jpg"),
                        name: "Prayer Request"),
                    SizedBox(
                      width: 10,
                    ),
                    Navigatetab(
                        onPressed: () {
                           Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => project()));
                        },
                        logo: Image.asset("assets/Projects.jpg"),
                        name: "Projects"),
                    SizedBox(
                      width: 10,
                    ),
                    Navigatetab(
                        onPressed: () {
                          social();
                        },
                        logo: Image.asset("assets/Social.png"),
                        name: "Our Socials"),
                  ],

                )
              ]),

                ),
              ),
              SizedBox( width: 10,)
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
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
                Navigatetab(onPressed: (){}, logo: Image.asset("assets/calender.png"), name: "Events"),
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
                Navigatetab(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>VideoPage()));}, logo: Image.asset("assets/Social.png"), name: "Our Socials"),

                 ],
            ),
                   // Consumer<NotificationDatabase>(
                   //   builder: (context , value , child) {
                   //     return ElevatedButton(onPressed: (){
                   //       value.inc();
                   //     }, child: Text("cli"));
                   //   }
                   // )
                 ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
