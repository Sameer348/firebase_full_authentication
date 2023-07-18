import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/posts_screen.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';
class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {

  final firestore= FirebaseFirestore.instance.collection('users');
  bool loading=false;
  final  _formKey= GlobalKey<FormState>();
  final nameControlller=TextEditingController();
  final postsController=TextEditingController();

  void clearText() {
    nameControlller.clear();
    postsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Add Firestore Data '),centerTitle: true,leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios)),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const  SizedBox(height: 50,),
          Form(key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,

                    // maxLines: 2,
                    controller: nameControlller,
                    decoration:const  InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'write something',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter data';

                      }return null;

                    },
                  //onTap: clearText,
                ),
                SizedBox(height: 20,),
                TextFormField(
                    keyboardType: TextInputType.text,

                    maxLines: 4,
                    controller: postsController,
                    decoration:const  InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'what is your mind?',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Thoughts';

                      }return null;

                    },
                  //  onTap: clearText,

                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          RoundButton(title: 'Add',loading: loading, ontap: (){


            if(_formKey.currentState!.validate()){
              setState(() {
                loading=true;
              });
              String id= DateTime.now().millisecondsSinceEpoch.toString();
              firestore.doc(id).set({
                'title':nameControlller.text.toString(),
                'description':postsController.text.toString(),
                'id':id,

              }).then((value) {setState(() {
                loading=false;
              });
                Utils().toastMessage('post add'.toString());
              }).onError((error, stackTrace) {
                setState(() {
                  loading=false;
                });
             Utils().toastMessage(error.toString());
              });
              clearText();
            }

          })
        ],),
      ),);
  }

}
