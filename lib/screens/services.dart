import 'dart:async';

import 'package:bccf/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class project extends StatefulWidget {
  const project({super.key});

  @override
  State<project> createState() => _projectState();
}

class _projectState extends State<project> {
  final _Duration = TextEditingController();
  final Amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void pledge() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Pledge'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _Duration,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Days Of Pledge'),
                  validator: (value) {
                    try {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of days';
                      }
                      else if (int.parse(value) < 0 ) {
                        return 'please enter correct days';
                      }
                    } catch (e) {
                      return 'invalid days';
                    }
                  },
                ),
                TextFormField(
                  controller: Amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                  validator: (value) {
                    try {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount';
                      } else if (int.parse(value) < 20) {
                        return 'please enter amount above 20/=';
                      }
                      ;
                    } catch (e) {
                      return "invalid amount";
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(); // Dismiss the current dialog
                  confirm();
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void confirm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Your Details',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
              "Days of Pledge: ${_Duration.text} days\nAmount: Ksh ${Amount.text}"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                sucess();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void sucess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Success',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Your Pledge has been submitted successfully.',
          style: GoogleFonts.poppins(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _Duration.clear();
              Amount.clear();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Custom_appbar()),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/Churchbuild.jpg"),
                      fit: BoxFit.cover,
                    )),
                  ),
                ]),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    child: Container(
                      height: 375,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'About The project',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(9.0),
                            child: Text(
                              "Note:	This	document	is	computer	generated	and	therefore	not	signed.	It	is	valid	document	issued	under	the	authority	of	The National	Transport	and	Safety	Authority This	document	is	computer	generated	and	therefore	not	signed.	It	is	valid	document	issued	under	the	authority	of	The National	Transport	and	Safety	Authority This	document	is	computer	generated	and	therefore	not	signed.	It	is	valid	document	issued	under	the	authority	of	The National	Transport	and	Safety	Authority ",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: ElevatedButton(
                                  child: Text("Pledge"),
                                  onPressed: () {
                                    pledge();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      fixedSize: const Size(140, 50),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      side: const BorderSide(
                                          color: Colors.blueGrey),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: ElevatedButton(
                                  child: Text("My Pledge"),
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      fixedSize: const Size(140, 50),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.grey,
                                      side: const BorderSide(
                                          color: Colors.blueGrey),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
