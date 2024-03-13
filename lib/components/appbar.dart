import 'package:bccf/components/notification.dart';
import 'package:bccf/main.dart';
import 'package:bccf/screens/login.dart';
import 'package:bccf/screens/notifications.dart';
import 'package:bccf/services/cache/NotificationDatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Custom_appbar extends StatefulWidget {
  const Custom_appbar({Key? key}) : super(key: key);

  @override
  State<Custom_appbar> createState() => _Custom_appbarState();
}

class _Custom_appbarState extends State<Custom_appbar> {
  final  announcements = supabase.from("announcements").stream(primaryKey: ["id"]);
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
   String getUsername() {
    final username = supabase.auth.currentSession!.user.email!.split('@')[0];
    return removeNumberInString(username);
  }

  String personname() {
    final username = getUsername();
    final personname = removeNumberInString(username);
    return personname;
  }

  String removeNumberInString(String stringToBeParsed) {
    String parsedString = '';
    stringToBeParsed.runes.forEach((element) {
      final eachChar = String.fromCharCode(element);
      final Number = int.tryParse(eachChar);
      if (Number == null) {
        parsedString += eachChar;
      }
    });
    return parsedString;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey.shade300,
        backgroundColor: Colors.grey.shade200,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
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
                            counter: 0
                        );
                      }
                  )
              ),
              SizedBox(width:5),
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder:(BuildContext context) =>[
                PopupMenuItem(child:ListTile(
                  leading:Icon(Icons.person),
                  title: Text(getUsername(), style:GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                  onTap:(){},
                )
                ),
                PopupMenuItem(child: ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title:Text("Logout"),
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
                ))
                ]),
            ],
          ),
        ],
      ),
    );
  }
}