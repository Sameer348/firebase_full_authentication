import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/ui/auth/login_screen.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../firebase_services/splash_services.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {

FirebaseAuth auth = FirebaseAuth.instance;
bool loading=false;
  final  _formKey= GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Sign Up'),),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(children: [
                  Text('SIGN UP',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700),),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration:const InputDecoration(hintText: 'Email',
                        helperText: 'enter email e.g sameer12@gmail.com',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }return null;
                      }),


                  const  SizedBox(height: 10,),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                      decoration:const  InputDecoration(hintText: 'Pasword',
                          prefixIcon: Icon(Icons.lock)),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Password';

                        }return null;

                      }
                  ),

                ],)),
            const SizedBox(height: 50,),
            RoundButton(title: 'Sign Up',
              loading: loading,
              ontap: () {
              if(_formKey.currentState!.validate()) {
                 signup();
              }

            },),
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already  have an account?"),
                TextButton(onPressed: (){Navigator.pop(context);}, child:Text("Login"), )
              ],)


          ],
        ),
      ),);
  }

  void signup(){
    setState(() {
    loading=true;
    });
    auth.createUserWithEmailAndPassword(
    email: emailController.text.toString(),
    password: passwordController.text.toString()).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    setState(() {
    loading=false;
    });


    }).onError((error, stackTrace) {

    Utils().toastMessage(error.toString());
    setState(() {
    loading=false;
    });
    });
    }


}
