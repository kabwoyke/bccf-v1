import 'package:flutter/material.dart';
class AppButton extends StatelessWidget {
   AppButton({super.key , required this.email , required this.password , required this.formKey});

  String email;
  String password;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: (){
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
    },

        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: const Center(
            child:  Text(
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

  }
}
