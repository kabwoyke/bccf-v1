import 'package:bccf/components/login_button.dart';
import 'package:bccf/components/text_input.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  String _emailError = "";
  final _formKey = GlobalKey<FormState>();

  bool isEmailValid(String email) {
    
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_,value,child ){
      return ListView(
        children: [
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: const Image(image: AssetImage('assets/logo.jpeg'), fit: BoxFit.contain , width: 200,height: 200,),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Center(
                      child: Text("LOGIN" , style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                  const SizedBox(height: 12.0,),
                  TextInput(
                    labelText: "Email", icon: Icons.email_sharp, onChanged: (emailText){

                    if (emailText == null || emailText.isEmpty || !isEmailValid(emailText)) {
                      // setState(() {
                      //   _emailError = "invalid email";
                      // });
                      return 'Please enter a valid email';
                    }
                    this.email = emailText;
                    return null;
                  },),

                  const SizedBox(height: 12.0,),
                  TextInput(
                      obsecureText: true,
                      labelText: "Password", icon: Icons.lock ,
                      onChanged:(passwordText){
                        if (passwordText == null || passwordText.isEmpty) {
                          return 'Please enter a valid password';
                        }
                        setState(() {
                          this.password = passwordText;
                        });
                        return null;
                      }),
                  const SizedBox(height: 10.0,),
                  Row(
                    children: [
                      const Text("Dont have an account?"),
                      GestureDetector(
                        child: const Text(
                          " Register here",
                          style: TextStyle(
                              color: Colors.blue
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 14,),
                  AppButton(email: email, password: password , formKey: _formKey,)
                ],
              ),
            ),
          )],
      );
    });
  }
}
