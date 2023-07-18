import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/firestore/firestore_list_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/login_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/posts_screen.dart';

import '../ui/auth/upload_image_screen.dart';

class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if( user != null){

      Timer(Duration(seconds: 2), () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //UploadImageScreen())));
          FirestoreScreen())));
      //PostScreen()
    }
    else{
      Timer(Duration(seconds: 2), () => Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen())));

    }
  }

}

