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
var rate,runtime,h;

  String t =
      "De Dana Dan (English: Hit left and right) is a 2009 Indian Hindi comedy film directed by Priyadarshan";

  Future moviedetail() async {
    http.Response details = await http.get(Uri.encodeFull(
        "http://api.themoviedb.org/3/movie/$id/casts?api_key=2931998c3a80d7806199320f76d65298"));
    this.setState(() {
      cast = json.decode(details.body);
      });
  }

  Future videodetail() async {
    http.Response video = await http.get(Uri.encodeFull(
        "http://api.themoviedb.org/3/movie/$id?api_key=2931998c3a80d7806199320f76d65298&append_to_response=videos"));
    this.setState(() {
      vid = json.decode(video.body);
  rate=vid["vote_average"];
 
  runtime=vid["runtime"];
 h= runtime/60;

 print(h);
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
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(
                  '$rate/10',
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
//             ConstrainedBox(

//               constraints: BoxConstraints(
// maxHeight: 250
//               ),
//               child: Container(
//                 height: height,
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: 250,
//                     // minHeight: 100
//                   ),
//                                   child: Column(
//                     children: <Widget>[
//                       GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (x == 0) {
//                                 t = a;
//                                 x = 1;
//                                 height = 100.0;
//                               } else {
//                                 a = t;
//                                 height = 150;
//                                 x = 0;
//                               }
//                             });
//                           },
//                           child: Text(
//                             "View more..",
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                vid["overview"],
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
              ),
              constraints: BoxConstraints(maxHeight: 300.0, minHeight: 50.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (x == 0) {
                        x = 1;
                      } else {
                        x = 0;
                      }
                    });
                  },
                  child: x == 1
                      ? Text(
                          "Read more..",
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          "Read less..",
                          style: TextStyle(color: Colors.grey),
                        )),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: x == 0
                  ? Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Status"),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            Text("Release Date"),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            Text("Run Time"),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            Text("Language"),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            vid["status"]==null?Text("-"):
                            Text(vid["status"]),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            vid["release_date"]==null?Text("-"):
                            Text(vid["release_date"]),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            // Text(vid["runtime"]),
                            runtime==null?Text("-"):
                            Text("$runtime min"),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            vid["original_language"]==null?Text("-"):
                            Text(vid["original_language"]),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                           
                          ],
                        ),
                      ],
                    )
                  : Text(""),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  "Casts",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                      color: Colors.black54),
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
                        ],
                      ),
                    );
                  },
                )),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  "Videos",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                      color: Colors.black54),
                ),
              ),
            ),
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
