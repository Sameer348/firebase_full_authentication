import 'package:flutter/material.dart';

import '../firebase_services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  SplashServices splashServices= SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(body:
    Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child:Image.asset('assets/images/splash.png'),),
      //  Text('Firebase App')
      ],
    ),);
  }
}
