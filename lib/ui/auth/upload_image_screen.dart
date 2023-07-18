

import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? _image;
  final picker= ImagePicker();
  //firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  Future getImageFromGallery()async{
    final  pickedFile= await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
setState(() {
  if(pickedFile!=null){
    _image = File (pickedFile.path );
  }else{
    print('no image picked');
  }
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          InkWell(
            onTap: (){
           getImageFromGallery();
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                height: 200,
                width: 200,
                child: _image !=null?  Image.file(_image!.absolute ) :Center(child: Icon(Icons.image),)

              )
            ),
          ),
          SizedBox(height: 40,),
          RoundButton(title: 'Upload Image', ontap: (){})
        ],),
      ),);
  }
}
