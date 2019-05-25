import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:last_app/about.dart';
import 'package:last_app/card.dart';
import 'package:last_app/data.dart';
import 'package:last_app/detail.dart';
import 'package:last_app/grid.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contSext) {
    return new MaterialApp(
      // home:UserOptions(),
      home: new ImageSplashScreen(),

      theme: ThemeData(
        primaryColor: Colors.red,
        // primarySwatch: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/Hview': (BuildContext context) => new Hview(),
        '/grid': (context) => MovieGrid(),
        'json': (context) => JsonTest(),
        '/details': (context) => Detail(),
        'about':(context)=> About() 
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

        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        // pathImage: "https://placeimg.com/640/480/nature/2",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
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
    Navigator.pushReplacementNamed(context, '/camera');
    //  Navigator.pushNamedAndRemoveUntil(context, '/camera');
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, '/camera');
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

class ImageSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<ImageSplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, '/Hview');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
              center: Alignment.center,
              radius: 3.0,
              colors: [Colors.red, Colors.orangeAccent],
            )),
            child: Center(
                child: Text("BOXOFFICE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontFamily: 'Poppins'))),
          )
        ],
      ),
    );
  }
}
