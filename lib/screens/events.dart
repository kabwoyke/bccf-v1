import 'package:bccf/components/notification.dart';
import 'package:bccf/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final List<Map<String, String>> events = [
    {
      'title': 'Event 1',
      'date': 'February 21, 2023',
      'location': 'Location 1',
      'imagePath': 'assets/kesha.jpg',
    },
    {
      'title': 'Event 2',
      'date': 'February 21, 2024',
      'location': 'Location 2',
      'imagePath': 'assets/hands.jpg',
    },
    // Add more events as needed
  ];
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
     body: SingleChildScrollView(
      child: Column(children: [
        
      ]),
     ),
    );
  }
}