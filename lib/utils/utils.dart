import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/colors.dart';
class Utils{

  static void  flushBarErrorMessage(String  message, BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          borderRadius: BorderRadius.circular(12),
          message: message,
          duration: Duration(seconds: 3),
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(Icons.error,size: 28,color: AppColors.whiteColor,),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }
  static void  flushBarSuccessMessage(String  message, BuildContext context) {
    showFlushbar(context: context,
        flushbar: Flushbar(
          borderRadius: BorderRadius.circular(12),
          message: message,
          duration: Duration(seconds: 3),
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.green,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(Icons.done, size: 28, color: AppColors.whiteColor,),
          flushbarPosition: FlushbarPosition.TOP,
        )
          ..show(context));
  }
void toastMessage(String message){


  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0

  );
}
}