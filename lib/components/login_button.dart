import 'package:bccf/services/AuthService.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AppButton extends StatelessWidget {
   AppButton({super.key , required this.email , required this.password , required this.formKey});
  String email;
  String password;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final userService = AuthService(context: context);
    return Consumer<AuthProvider>(builder: (_,value,child){
      return Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () async{
            value.loading();
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              await userService.login(email, password);
              value.notLoading();
            }
          },

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
