import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/ui/auth/login_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/add_posts_screen.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';

import 'add_firestore_data.dart';
class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({Key? key}) : super(key: key);

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
   final auth= FirebaseAuth.instance;

  // final searchFilterController=TextEditingController();
   final firestore= FirebaseFirestore.instance.collection('users').snapshots();
   CollectionReference ref= FirebaseFirestore.instance.collection('users');
   final editController=TextEditingController();
   final desController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Fire Store'),centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace) {
              Utils.flushBarSuccessMessage(error.toString(), context);
            });
          }, icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 10,)
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddFirestoreDataScreen()));
      },child: Icon(Icons.add),),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [

          // TextFormField(
          //   controller: searchFilterController,
          //   onChanged: (String value){
          //     setState(() {
          //
          //     });
          //   },
          //   decoration: InputDecoration(
          //     hintText: 'Search',
          //     border: OutlineInputBorder(),
          //
          //   ),),
          StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (BuildContext  context ,AsyncSnapshot<QuerySnapshot> snapshot, ) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else{

              }
            return Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
        itemBuilder: (context , index){
     return ListTile(
       onTap: (){

         // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
         //   'title':editController.text.toLowerCase()
         // }).then((value) {
         //   Utils().toastMessage('post updated'.toString());
         // }).onError((error, stackTrace) {
         //   Utils().toastMessage(error.toString());
         // });

       },

       title: Text(snapshot.data!.docs[index]['title'].toString()),
       subtitle: Text(snapshot.data!.docs[index]['description'].toString()),
       trailing:   PopupMenuButton(
         icon: Icon(Icons.more_vert),
          itemBuilder: (context)=>[
          PopupMenuItem(
          value:1,
          child: ListTile(
          onTap: (){
          Navigator.pop(context);

          showDialog(

              context: context,
              builder: (BuildContext  context){

                return AlertDialog(

                  actions: [
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')),
                    TextButton(onPressed: (){

                      Navigator.pop(context);


                      ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                        'title':editController.text.toLowerCase(),
                      //  'description':desController.text.toLowerCase()
                      }).then((value) {
                        Utils().toastMessage('post updated'.toString());
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                      //
                    }
                        , child: Text('Update'))
                  ],
                  title: Text('Update'),
                  content: Container(
                    height: 100,
                    child: Column(
                      children: [
                        TextField(controller: editController,decoration: InputDecoration(hintText: 'Edit Here'),),
                     //   TextField(controller: desController,decoration: InputDecoration(hintText: 'Edit Here'),),
                      ],
                    ),
                  ),

                );

              });

          },
          title: Text('Update'),leading: Icon(Icons.edit),)),

          PopupMenuItem(
          onTap: (){
          Utils().toastMessage('Post Deleted');
          ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();

          },
          value:2,
          child: ListTile(title: Text('Delete'),leading: Icon(Icons.delete),)),]),);})
            );
            }
          ),

          // Expanded(
          //   child: FirebaseAnimatedList(
          //       defaultChild: Center(child: Text('loading')),
          //       query: ref,
          //       itemBuilder: (context, snapshot,animation,index){
          //     return ListTile(title: Text(snapshot.child('title').value.toString()),
          //       subtitle:Text( snapshot.child('description').value.toString()),
          //      trailing: Text( snapshot.child('id').value.toString()),
          //     );
          //
          //
          //   }),
          // )

        ],),
      ),);
  }
  Future <void> showMyDialog(String title, String id, )async{
   editController.text= title;


    return showDialog(
        context: context,
        builder: (BuildContext  context){
          return AlertDialog(
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')),
              TextButton(onPressed: (){

                Navigator.pop(context);


                // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                //   'title':editController.text.toLowerCase()
                // }).then((value) {
                //   Utils().toastMessage('post updated'.toString());
                // }).onError((error, stackTrace) {
                //   Utils().toastMessage(error.toString());
                // });
              //
               }
              , child: Text('Update'))
            ],
            title: Text('Update'),
            content: Container(child: TextField(controller: editController,decoration: InputDecoration(hintText: 'Edit Here'),),),

          );

        });
  }
}

