import 'package:bccf/models/UserModel.dart';
import 'package:bccf/services/AuthService.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RegistrationButton extends StatelessWidget {
  RegistrationButton({required this.submitHandler,});
  final Function() submitHandler;
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
                "REGISTER",
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
