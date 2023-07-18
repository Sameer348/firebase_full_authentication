import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_practice/ui/auth/login_with_phone_number_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/posts_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/signup_screen.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';

import '../../firebase_services/splash_services.dart';
import '../../firestore/firestore_list_screen.dart';
import 'forgot_password_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

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
  void login(){
    setState(() {
      loading = true;
    });
    auth.signInWithEmailAndPassword(email: emailController.text,
        password: passwordController.text.toString()).then((value)  {
      Utils.flushBarErrorMessage(value.user!.email.toString(), context,);
    //  Utils.flushBarSuccessMessage('succesfull login'.toString(), context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => FirestoreScreen()));

      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils.flushBarErrorMessage(

        error.toString(), context,);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('login'),),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Form(
         key: _formKey,
         child: Column(children: [
           Text('LOGIN',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500),),
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
            RoundButton(title: 'login', loading: loading, ontap: () {

       if(_formKey.currentState!.validate()) {
       login();
              }
            },),
            Align(alignment: Alignment.topRight,
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));

              }, child:Text("Forget password"), ),
            ),
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Don't have an account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));

              }, child:Text("Sign Up"), )
            ],),
            const SizedBox(height: 10,),

           InkWell(
         onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhoneNo()));
       },
     child:   Container(
       width: double.infinity,
       height: 40,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),border: Border.all(color: Colors.black)),
    child: Center(child: Text('login with phone no')),),
)
          ],
      ),
        ),),
    );
  }
}
