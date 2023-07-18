import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/ui/auth/login_screen.dart';
import 'package:flutter_firebase_practice/ui/auth/posts/add_posts_screen.dart';
import 'package:flutter_firebase_practice/utils/utils.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth= FirebaseAuth.instance;
  final ref= FirebaseDatabase.instance.ref('post');
  final searchFilterController=TextEditingController();
  final editController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Posts Screen'),centerTitle: true,
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
  Navigator.push(context, MaterialPageRoute(builder: (context) =>const  AddPostsScreen()));
},child: Icon(Icons.add),),
       body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
         child: Column(children: [

           TextFormField(
             controller: searchFilterController,
             onChanged: (String value){
               setState(() {

               });
             },
             decoration: InputDecoration(
             hintText: 'Search',
             border: OutlineInputBorder(),

           ),),
           Expanded(child: StreamBuilder(
             stream: ref.onValue,
             builder: (context , AsyncSnapshot<DatabaseEvent>snapshot){
               if(!snapshot.hasData){
                 return CircularProgressIndicator();
               }else{

                 Map <dynamic , dynamic> map= snapshot.data!.snapshot.value as dynamic;
                 List<dynamic> list= [];
                 list.clear();
                 list= map.values.toList();

                 return ListView.builder(
                     itemCount: snapshot.data!.snapshot.children.length,
                     itemBuilder: (context, index){

                       ///// fOR Search filer
                       final title=list[index]['title'].toString();
                     //  final description=list[index]['description'].toString();
                       if(searchFilterController.text.isEmpty){
                         return ListTile(
                           title:Text(list[index]['title'].toString()),
                           subtitle: Text(list[index]['description'].toString()),
                           trailing:PopupMenuButton(
                             icon: Icon(Icons.more_vert),
                             itemBuilder: (context)=>[
                               PopupMenuItem(
                                   value:1,
                                   child: ListTile(
                                       onTap: (){
                                         Navigator.pop(context);
                                         showMyDialog(title ,list[index]['id'].toString() );
                                       },
                                     title: Text('Update'),leading: Icon(Icons.edit),)),

                               PopupMenuItem(
                                   onTap: (){
                                     Utils().toastMessage('Post Deleted');
                                     ref.child(list[index]['id'].toString()).remove();

                                   },
                                   value:2,
                                   child: ListTile(title: Text('Delete'),leading: Icon(Icons.delete),)),

                             ]


                           )
                         );
                       }else if(title.toLowerCase().contains(searchFilterController.text.toLowerCase().toString())){
                         return ListTile(
                           title:Text(list[index]['title'].toString()),
                           subtitle: Text(list[index]['description'].toString()),
                           trailing: Text(list[index]['id'].toString()),
                         );
                       } else{
                        Container();
                       }
                     });
               }

             },
           )),

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
    //desController.text=description;

    return showDialog(
        context: context,
        builder: (BuildContext  context){
          return AlertDialog(
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')),
              TextButton(onPressed: (){
                
                Navigator.pop(context);
                ref.child(id).update({
                  'title':editController.text.toLowerCase()

                }).then((value) {
                  Utils().toastMessage('post update');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString(), );
                });

                }, child: Text('Update'))
            ],
            title: Text('Update'),
            content: Container(child: TextField(controller: editController,decoration: InputDecoration(hintText: 'Edit Here'),),),

          );

        });
  }
}
