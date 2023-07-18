import 'package:flutter/material.dart';

import 'colors.dart';



class RoundButton extends StatelessWidget {

  final String title;
 final bool loading;
  final VoidCallback ontap;
  const RoundButton({Key? key, required this.title,this.loading=false, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(color: AppColors.buttonColor,borderRadius: BorderRadius.circular(10)),
        height: 40,
        width: 300,
        child: Center(child:
       loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):
        Text(title,style: TextStyle(color: AppColors.whiteColor),)),
      ),
    );
  }
}