

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

final emailController = TextEditingController();
final  _formKey= GlobalKey<FormState>();
final auth= FirebaseAuth.instance;
bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password '),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Form(
            key: _formKey,
            child: TextFormField(
                keyboardType: TextInputType.emailAddress  ,
                controller: emailController,
                decoration:const InputDecoration(hintText: 'Enter email',

                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Your  Email';
                  }return null;
                }),
          ),
          SizedBox(height: 40,),
          RoundButton(
              loading: loading,title: 'Password Forget', ontap: (){

            if(_formKey.currentState!.validate()){
              setState(() {
                loading=true;
              });
         auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
           setState(() {
             loading=false;
           });
           Utils.flushBarSuccessMessage('We have sent you email to recover password please check email', context);
          }).onError((error, stackTrace) {
           setState(() {
             loading=false;
           });
          Utils.flushBarErrorMessage(error.toString(), context);
 });
            }
          })
        ],),
      ),);
  }
}
