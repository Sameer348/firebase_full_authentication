import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/posts_screen.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';
class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({Key? key}) : super(key: key);

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
final databaseRef= FirebaseDatabase.instance.ref('post');
  bool loading=false;
  final  _formKey= GlobalKey<FormState>();
  final nameControlller=TextEditingController();
  final postsController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Add Posts'),centerTitle: true,),
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

                  }
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

                  }
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

            databaseRef.child(id).set({
              'id':id,
              'title': nameControlller.text.toString(),
              'description':postsController.text.toString()

            }).then((value) {
          Utils.flushBarSuccessMessage('Post Add', context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
          setState(() {
            loading=false;
          });
            }).onError((error, stackTrace) {
              Utils.flushBarErrorMessage(error.toString(), context);
              setState(() {
                loading=false;
              });
            });
          }

        })
      ],),
    ),);
  }

}
