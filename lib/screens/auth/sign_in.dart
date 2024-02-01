import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {

  AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0,
        title: Text("TEST APP"),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        child: Center(
          child: Container(
            width: 300,
            height: 66,
            child: ElevatedButton(
            onPressed: () async{
              MyUser result= await _authService.signInAnon();
              if(result==null){
                print('No user');
              }
              else{
                print('yes user ☺ ${result.userId}');
              }
            },
            child: Text("Sign in"),
      ),
          ),
        ),),
    );
  }
}
