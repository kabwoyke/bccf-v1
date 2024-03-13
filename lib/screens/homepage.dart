import 'package:bccf/components/appbar.dart';
import 'package:bccf/components/navigater.dart';
import 'package:bccf/components/word.dart';
import 'package:bccf/screens/events.dart';
import 'package:bccf/screens/pledge.dart';
import 'package:bccf/screens/prayer.dart';
import 'package:bccf/screens/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void social() {
    // the social media platform
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Container(
              height: 80,
              width: 80,
              child: Image.asset("assets/logo.jpeg"),
            ),
            title: Text(
              "Our social Media Platforms,",
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w700),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            content: Container(
              height: 190,
              width: double.maxFinite,
              child: Column(
                children: [
                  GestureDetector(
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Image.asset("assets/facebook logo.png"),
                          title: Text(
                            "Facebook",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "Click To Join Our Facebook Page",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Container(
                              height: 40,
                              width: 80,
                              child: Image.asset("assets/YouTubelogo.png")),
                          title: Text(
                            "YouTube",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "Click To Join our Youtube Channel",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"))
            ],
          );
        }); // which ends here
  }

  var offer = [
    "SACRAFICE",
    "OFFERING",
    "FIRSTFRUIT",
    "TITHE",
    "PROJECT"
  ]; // the offering module
  final _Phonenumber = TextEditingController();
  final Amount = TextEditingController();
  String? selectedOffering = "OFFERING";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void Offering() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enter Pledge',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _Phonenumber,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: 'Enter Phone number',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone number';
                          } else {
                            RegExp kenyanPhoneRegex = RegExp(
                                r'^(?:\+?254|\0)?(7(?:[0125]\d{5}|[789]\d{6}))$');
                            if (!kenyanPhoneRegex.hasMatch(value)) {
                              return 'Invalid Phone number';
                            }
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Select Your Offering",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        onSaved: (offering) {
                          setState(() {
                            this.selectedOffering = offering.toString();
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        hint: Text(
                          "Select Offering Type",
                          style: TextStyle(fontSize: 14),
                        ),
                        onChanged: (val) {
                          setState(() {
                            this.selectedOffering = val;
                          });
                        },
                        items: offer.map((g) {
                          return DropdownMenuItem<String>(
                            value: g,
                            child: Text(
                              g,
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        iconSize: 24,
                        isDense: true,
                        itemHeight: 48,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          prefixIcon: Icon(Icons.wallet),
                        ),
                        validator: (value) {
                          try {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the amount';
                            }
                          } catch (e) {
                            return "invalid amount";
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          confirm();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
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
            "Phonenumber: ${_Phonenumber.text}\n\n Offering: ${selectedOffering}\n\n Ksh ${Amount.text} /=",
            style:
            GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          actions: [
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
          'Your offer has been sent successfully.',
          style: GoogleFonts.poppins(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _Phonenumber.clear();
              Amount.clear();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    ); // which ends here
  }

  void service() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Container(
            height: 80,
            width: 80,
            child: Image.asset("assets/logo.jpeg"),
          ),
          title: Text('Order Of Services '),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1
                      )
                  ),
                  child: ListTile(
                    title: Text('Morning Devotion',style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                    subtitle: Text("Everyday: 7am- 9am",style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1
                      )
                  ),
                  child: ListTile(
                    title: Text('Lunch Hour', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                    subtitle: Text("Everyday: 12pm - 2pm",style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1
                      )
                  ),
                  child: ListTile(
                    title: Text('Wednesday', style:GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),),
                    subtitle: Text("Evening Revial: 5pm - 8pm", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1
                      )
                  ),
                  child: ListTile(
                    title: Text('sunday', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                    subtitle: Column(
                      children: [
                        Text('first service: 7am - 10am',style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                        Text('second service: 10am - 1pm',style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                        Text('sunday school: 9am - 11pm ',style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1
                      )
                  ),
                  child: ListTile(
                    title: Text("friday Kesha", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                    subtitle: Text('from 8pm till late',style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Navigatetab(
                        onPressed: () {
                          service();
                        },
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
                        onPressed: () {
                          Offering();
                        },
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
          ],
        ),
      ),
    );
  }
}