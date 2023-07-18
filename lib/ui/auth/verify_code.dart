import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/firestore/firestore_list_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/posts_screen.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';
class VerifyCodeScreen extends StatefulWidget {
 final  String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  final verifyController=TextEditingController();
  bool loading=false;
  final auth= FirebaseAuth.instance;
  final  _formKey= GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    verifyController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Number'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 50,),
          Form(
            key: _formKey,
            child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: verifyController,
                decoration:const InputDecoration(hintText: '6 digit code',

                  prefixIcon: Icon(Icons.phone_android),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return '6 digit code';
                  }return null;
                }),
          ),
          const SizedBox(height: 80,),

          RoundButton(

              loading: loading,
              title: 'login', ontap: (){
            if(_formKey.currentState!.validate()){
              verifyNumber() ;
            }


          })
        ],),
      ),
    );
  }
  void verifyNumber ()async{
    setState(() {
      loading=true;
    });

  final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: verifyController.text.toString());
  try{
   await auth.signInWithCredential(credential);
   Navigator.push(context, MaterialPageRoute(builder: (context) =>FirestoreScreen()));
   }catch(e){

setState(() {
  loading=false;
});
  }
    Utils.flushBarErrorMessage(e.toString(), context);
  }

}
