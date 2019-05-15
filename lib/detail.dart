import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  const Detail({Key key, this.data}) : super(key: key);
  final int data;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var height = 100.0, cast, vid, x = 1;
  String a, id;

  String t =
      "De Dana Dan (English: Hit left and right) is a 2009 Indian Hindi comedy film directed by Priyadarshan";

  Future moviedetail() async {
    http.Response details = await http.get(Uri.encodeFull(
        "http://api.themoviedb.org/3/movie/$id/casts?api_key=2931998c3a80d7806199320f76d65298"));
    this.setState(() {
      cast = json.decode(details.body);
      print(cast["cast"].length);
      //  print("ankit");
    });
  }

  Future videodetail() async {
    http.Response video = await http.get(Uri.encodeFull(
        "http://api.themoviedb.org/3/movie/$id?api_key=2931998c3a80d7806199320f76d65298&append_to_response=videos"));
    this.setState(() {
      vid = json.decode(video.body);
      print(vid["videos"]["results"]);
      print("hogya kaam");
      print(vid["videos"]["results"].length);
      // print(vid.length);
      //  print("ankit");
    });
  }

  Future play(txt) async {
    var url = "https://www.youtube.com/watch?v=" + txt;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    id = "${widget.data}";
    this.moviedetail();
    this.videodetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("qw"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              // color: ColoRrs.green,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    // top: 10,
                    child: Container(
                      height: 150,
                      color: Colors.red,
                      child: SizedBox.expand(
                          child: Image.network(
                              "https://image.tmdb.org/t/p/w500/" +
                                  vid["backdrop_path"],
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 125,
                    left: 125,
                    child: Container(
                      decoration: new BoxDecoration(
                        // color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      height: 100,
                      width: 100,
                      // color: Colors.blue,
                      child: SizedBox.expand(
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/" +
                              vid["poster_path"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            AnimatedContainer(
              margin: EdgeInsets.all(20.0),
              height: height,
              // color: Colors.cyan,
              duration: Duration(milliseconds: 0),
              child: Container(
                height: 40.0,
                child: Column(
                  children: <Widget>[
                    Flexible(
                        child: Text(
                      vid["overview"],
                      overflow: TextOverflow.clip,
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (x == 0) {
                            t = a;
                            x = 1;
                            height = 100.0;
                          } else {
                            a = t;
                            height = 150;
                            x = 0;
                          }
                        });
                      },
                        child: Text(
                      "View more..",
                    )),
                  ],
                ),
              ),
            ),
            Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cast["cast"].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.red,
                            backgroundImage: cast["cast"][index]
                                        ["profile_path"] ==
                                    null
                                ? NetworkImage(
                                    "http://sfwallpaper.com/images/image-not-available-11.jpg")
                                : NetworkImage(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        cast["cast"][index]["profile_path"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(cast["cast"][index]["name"]),
                          // Text(cast["cast"][index]["name"])
                        ],
                      ),
                    );
                  },
                )),
            Container(
              height: 250.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // height: ,
                itemCount: vid["videos"]["results"].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => play(vid["videos"]["results"][index]["key"]),
                    child: new Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 170,
                            width: 120,
                            child: Builder(builder: (BuildContext context) {
                              try {
                                return Image.network(
                                  'https://image.tmdb.org/t/p/w500/' +
                                      vid["poster_path"],
                                  fit: BoxFit.fitHeight,
                                );
                              } catch (e) {
                                return Image.network(
                                  'http://sfwallpaper.com/images/image-not-available-11.jpg',
                                  fit: BoxFit.fitHeight,
                                );
                              }
                            }),
                          ),
                          Flexible(
                            child: Text(vid["videos"]["results"][0]["name"],
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.clip),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}