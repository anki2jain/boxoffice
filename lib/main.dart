import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:last_app/card.dart';
// import 'card.dart';
import 'package:last_app/data.dart';
import 'package:last_app/detail.dart';
import 'package:last_app/grid.dart';
import 'package:last_app/profile.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Hview(),
      debugShowCheckedModeBanner: false,
      routes: <String , WidgetBuilder>{
      '/camera': (BuildContext context) => new Hview(),
      '/grid': (context) => MovieGrid(),
      'json':(context)=> JsonTest(),
      '/details':(context)=> Detail(),


      // '/go':(BuildContext context) => UserOptions()
      },
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "ERASER",
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        // pathImage: "https://placeimg.com/640/480/nature/2",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "PENCIL",
        description: "Ye indulgence unreserved connection alteration appearance",
        // pathImage: "https://placeimg.com/640/480/nature/3",
        
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        // pathImage: "https://placeimg.com/640/480/nature/4",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context,'/camera');
  //  Navigator.pushNamedAndRemoveUntil(context, '/camera');
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context,'/camera');
    // Navigator.pushNamed(context, '/go');
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
// class UserOptions extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return new UserOptionsState();
//   }
// }

// class UserOptionsState extends State<UserOptions> {
// //save the result of gallery file
//   File galleryFile;

// //save the result of camera file
//   File cameraFile;

//   @override
//   Widget build(BuildContext context) {
//     //display image selected from gallery
//     imageSelectorGallery() async {
//       galleryFile = await ImagePicker.pickImage(
//         source: ImageSource.gallery,
//         // maxHeight: 50.0,
//         // maxWidth: 50.0,
//       );
//       print("You selected gallery image : " + galleryFile.path);
//       setState(() {});
//     }

//     //display image selected from camera
//     imageSelectorCamera() async {
//       cameraFile = await ImagePicker.pickImage(
//         source: ImageSource.camera,
//         //maxHeight: 50.0,
//         //maxWidth: 50.0,
//       );
//       print("You selected camera image : " + cameraFile.path);
//       setState(() {});
//     }

//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Image Picker'),
//       ),
//       body: new Builder(
//         builder: (BuildContext context) {
//           return new Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//              FloatingActionButton(
//                backgroundColor: Colors.red,
//                onPressed: hello,
//              ),
//              RaisedButton(
//                child: Text("Change route"),
//                onPressed: goo,
//              ),
//               new RaisedButton(
//                 child: new Text('Select Image from Gallery'),
//                 onPressed: imageSelectorGallery,
//               ),
//               new RaisedButton(
//                 child: new Text('Select Image from Camera'),
//                 onPressed: imageSelectorCamera,
//               ),
//               displaySelectedFile(galleryFile),
//               displaySelectedFile(cameraFile)
//             ],
//           );
//         },
//       ),
//     );
//   }
//   void goo(){
//     Navigator.pushNamed(context,'.');
//   }
// void hello() {

// setState(() {

 
// Fluttertoast.showToast(
// msg: "You have pushed the button time.",
// textColor: Colors.white,
// toastLength: Toast.LENGTH_SHORT,
// timeInSecForIos: 1,
// gravity: ToastGravity.BOTTOM,
// backgroundColor: Colors.indigo,
// );
// });
// }
//   Widget displaySelectedFile(File file) {
//     return new CircleAvatar(
//       radius: 50,
//       backgroundColor: Colors.red,
// //child: new Card(child: new Text(''+galleryFile.toString())),
// //child: new Image.file(galleryFile),
//       child: file == null
//           ? new Text('')
//           :  new Image.file(file)
//     );
//   }
// }