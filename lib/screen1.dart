import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
//save the result of gallery file
  File galleryFile;

//save the result of camera file
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {});
    }

    //display image selected from camera
    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );
      print("You selected camera image : " + cameraFile.path);
      setState(() {});
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
             FloatingActionButton(
               backgroundColor: Colors.red,
               onPressed: hello,
             ),
             RaisedButton(
               child: Text("Change route"),
               onPressed: goo,
             ),
              new RaisedButton(
                child: new Text('Select Image from Gallery'),
                onPressed: imageSelectorGallery,
              ),
              new RaisedButton(
                child: new Text('Select Image from Camera'),
                onPressed: imageSelectorCamera,
              ),
              displaySelectedFile(galleryFile),
              displaySelectedFile(cameraFile)
            ],
          );
        },
      ),
    );
  }
  void goo(){
    Navigator.pushNamed(context,'.');
  }
void hello() {

setState(() {

 
Fluttertoast.showToast(
msg: "You have pushed the button time.",
textColor: Colors.white,
toastLength: Toast.LENGTH_SHORT,
timeInSecForIos: 1,
gravity: ToastGravity.BOTTOM,
backgroundColor: Colors.indigo,
);
});
}
  Widget displaySelectedFile(File file) {
    return new CircleAvatar(
      radius: 50,
      backgroundColor: Colors.red,
//child: new Card(child: new Text(''+galleryFile.toString())),
//child: new Image.file(galleryFile),
      child: file == null
          ? new Text('')
          :  new Image.file(file)
    );
  }
}