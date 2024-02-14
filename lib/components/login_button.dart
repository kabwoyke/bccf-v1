import 'package:bccf/services/AuthService.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AppButton extends StatelessWidget {
   AppButton({super.key , required this.email , required this.password , required this.submitHandler ,required this.formKey});
  final String email;
  final String password;
  final  Function() submitHandler;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {

    return Consumer<AuthProvider>(builder: (_,value,child){
      return Material(
        color: Colors.blue,
        child: InkWell(
          onTap: submitHandler,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child:  Center(
              child: value.isLoading ? Container(width: 25 , height: 25 , child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5, )) : Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
            ),
          ),
        ),
      );
    }) ;

  }
}
