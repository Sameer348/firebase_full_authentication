import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/ui/auth/verify_code.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';
class LoginWithPhoneNo extends StatefulWidget {
  const LoginWithPhoneNo({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNo> createState() => _LoginWithPhoneNoState();
}

class _LoginWithPhoneNoState extends State<LoginWithPhoneNo> {
  final phonenoController=TextEditingController();
bool loading=false;
final auth= FirebaseAuth.instance;
  final  _formKey= GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    phonenoController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login with phone number'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 50,),
          Form(
            key: _formKey,
            child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: phonenoController,
                decoration:const InputDecoration(hintText: '+1 2345678899',

                  prefixIcon: Icon(Icons.phone_android),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Phone Number';
                  }return null;
                }),
          ),
          const SizedBox(height: 80,),

          RoundButton(

              loading: loading,
              title: 'login', ontap: (){
                if(_formKey.currentState!.validate()){
                  logWithPhone() ;
                }


          })
        ],),
      ),
    );
  }
  void logWithPhone (){
    setState(() {
      loading = true;
    });
    auth.verifyPhoneNumber(
      phoneNumber: phonenoController.text,
      verificationCompleted:  (_){
        setState(() {
          loading = false;
        });
      },
      verificationFailed:(e){

        Utils.flushBarErrorMessage(e.toString(), context);
        setState(() {
          loading = false;
        });

      },
      codeSent: (String verification, int? token){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>VerifyCodeScreen(verificationId:verification ,)));
        setState(() {
          loading = false;
        });
      },
      codeAutoRetrievalTimeout: (e){
        Utils.flushBarErrorMessage(e.toString(), context);
        setState(() {
          loading = false;
        });
      },);
  }
}
