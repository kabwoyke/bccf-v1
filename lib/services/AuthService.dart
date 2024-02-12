import 'package:bccf/main.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
class AuthService {
  final BuildContext context;

  AuthService({required this.context});
    Future<void>login (String email , String password) async {
      try{
        final response = await supabase.auth.signInWithPassword(password: password , email: email);
        print(response.user);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Success")),
          );
        });
      } on AuthException catch(error) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("${error.message}")),
          );
        });
      }
      catch(e){
        print(e);
      }
    }
}