import 'dart:io';

import 'package:bccf/components/notification.dart';
import 'package:bccf/screens/editprofile.dart';
import 'package:bccf/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'John Doe'; // Initial values
  String _email = 'john@example.com';
  String _bio = 'Flutter enthusiast';
  File? _image;

  void _editProfile() async {
    final Map<String, dynamic> result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentProfileImage: _image ?? File(''),
          currentName: _name,
          currentEmail: _email,
          currentBio: _bio,
        ),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _name = result['name'] ?? _name;
        _email = result['email'] ?? _email;
        _bio = result['bio'] ?? _bio;
        _image = result['profileImage'] as File?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      automaticallyImplyLeading: false,
        shadowColor: Colors.grey.shade300,
        backgroundColor: Colors.grey.shade200,
        toolbarHeight: 70,
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
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        actions: [
          Row(
            children: [
              NotificationIcon(icon: Icons.notifications, counter: 5),
              SizedBox(width:10),
              Padding(
                padding: const EdgeInsets.only(top:22),
                child: Column(
                  children: [

                  ],
                ),
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top:22),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen()));
                        print("logged out");
                      },
                      child: Icon(
                        Icons.logout_rounded,
                      color: Colors.black,
                      size: 25,),
                    ),
                    Text('Logout',
                    style:GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight:FontWeight.w400 
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox( width: 10,)
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(_name),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(_email),
            SizedBox(height: 20),
             Text(
              'Gender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Male'), 
            SizedBox(height: 20),
            Text(
              'Bio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(_bio),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editProfile,
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}


