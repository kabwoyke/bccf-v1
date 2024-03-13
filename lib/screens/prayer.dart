import 'package:bccf/components/appbar.dart';
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

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    final name = _nameController.text;
    final request = _requestController.text;

    final supabase = Supabase.instance.client;
    try {

      await supabase
    .from('prayer_request')
    .insert({'name': name, 'request': request});

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
            'Your request has been submitted successfully.',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.clear();
                _requestController.clear();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      
    } catch (e) {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "${e}",
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      
    }
      
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Custom_appbar()),
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
                key:_formKey,
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