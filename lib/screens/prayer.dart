import 'package:bccf/components/button.dart';
import 'package:bccf/components/notification.dart';
import 'package:bccf/components/text_input.dart';
import 'package:bccf/main.dart';
import 'package:bccf/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Prayerpage extends StatefulWidget {
  const Prayerpage({Key? key}) : super(key: key);

  @override
  _PrayerpageState createState() => _PrayerpageState();
}

class _PrayerpageState extends State<Prayerpage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _requestController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _requestController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      final name = _nameController.text;
      final request = _requestController.text;

      // Here you can add your Supabase logic to save the data

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success',
          style: GoogleFonts.poppins(
            fontSize:18,
            fontWeight: FontWeight.w600
          ),
          ),
          content: Text('Your request has been submitted successfully.',
          style: GoogleFonts.poppins(
            fontSize: 15
          ),),
          actions: [
            TextButton(
              onPressed: () {
              _nameController.clear();
              _requestController.clear();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Welcome To The Prayer Form",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/Prayer.jpg',
                height: 100,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Colors.grey.shade200,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Your Name",
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _requestController,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your request';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Your Request",
                          icon: Icon(Icons.comment),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Submit",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                       minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.8, // 50% of screen width
                        MediaQuery.of(context).size.height * 0.07, // 7% of screen height
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}