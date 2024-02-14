import 'package:bccf/components/registration_button.dart';
import 'package:bccf/components/text_input.dart';
import 'package:bccf/models/UserModel.dart';
import 'package:bccf/screens/login.dart';
import 'package:bccf/services/AuthService.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var gender = ["MALE" , "FEMALE"];
  var _formKey = GlobalKey<FormState>();
  String first_name = "";
  String last_name = "";
  String password = "";
  String? selectedGender = "";
  String phone_number = "";
  String email = "";

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    final userService = AuthService(context: context);
    return  Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 14),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Register", style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),),
                    TextInput(
                      onSave: (f_name){
                        this.first_name = f_name!;
                      },
                      labelText: "First Name",
                      icon: Icons.text_fields_outlined,
                      onChanged: (String? f_name){
                        if(f_name == null || f_name.isEmpty || f_name.length < 3){
                          return "First name is required";
                        }

                        return null;
                        // setState(() {
                        //   this.first_name = f_name;
                        // });

                      },
                    ),
                    const SizedBox(height: 12.0,),
                    TextInput(
                      onSave: (l_name){
                        this.last_name = l_name!;
                      },
                      labelText: "Last Name",
                      icon: Icons.text_fields_outlined,
                      onChanged: (String? l_name){
                        if(l_name == null || l_name.isEmpty || l_name.length < 3){
                          return "Last name is required ";
                        }

                      },
                    ),
                    const SizedBox(height: 12.0,),
                    TextInput(
                      onSave: (contact){
                        this.phone_number = contact!;
                      },
                      labelText: "Contact Number",
                      icon: Icons.phone,
                      onChanged: (String? phone){
                        if(phone == null || phone.isEmpty){
                          return "Phone number cant be empty";
                        }

                      },
                    ),
                    const SizedBox(height: 12.0,),
                    DropdownButtonFormField2<String>(
                        onSaved: (gen){
                          setState(() {
                            this.selectedGender = gen.toString();
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint:Text("Select Gender"),
                        onChanged: (val){
                          setState(() {
                            this.selectedGender = val;
                          });
                          // selectedGender = val;
                        },
                        items: gender.map((g){
                          return DropdownMenuItem
                            (
                            value: g,
                            child: Text(g),
                          );
                        }).toList()
                    ),
                    const SizedBox(height: 12.0,),
                    TextInput(
                      onSave: (email){
                        this.email = email!;
                      },
                      labelText: "Email", icon: Icons.email,
                      onChanged: (emailText){
                        if (emailText == null || emailText.isEmpty || !isEmailValid(emailText)) {
                          // setState(() {
                          //   _emailError = "invalid email";
                          // });
                          return 'Please enter a valid email';
                        }

                        // this.email = emailText;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0,),
                    TextInput(
                      onSave: (password){
                        this.password = password!;
                      },
                      labelText: "Password",
                      icon: Icons.password,
                      obsecureText: true,
                      onChanged: (passwordText){
                        if (passwordText == null || passwordText.isEmpty) {
                          return 'Please enter a valid password atleast 6 char(s)';
                        }
                        // setState(() {
                        //   this.password = passwordText;
                        // });
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0,),
                    Consumer<AuthProvider>(builder: (_,value,child){
                      return RegistrationButton
                        (
                        submitHandler: () async {
                          if (_formKey.currentState!.validate()) {
                             value.loading();
                            _formKey.currentState!.save();
                            // print(first_name);
                            await userService.register(
                                UserModel(email: email,
                                    first_name: first_name,
                                    last_name: last_name,
                                    phone_number:phone_number,
                                    gender: selectedGender!,
                                    password: password
                                ));
                            value.notLoading();
                          }
                        },
                      );
                    }),

                    const SizedBox(height: 12.0,),
                    Row(
                      children: [
                        const Text("Have an account?"),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => LoginScreen())
                            );
                          },
                          highlightColor: Colors.blue,
                          child:  Text(
                            " Login here",
                            style: TextStyle(
                                color: Colors.blue.shade500
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
