import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:last_app/detail.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, this.idea}) : super(key: key);
  final int idea;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var actor, mov, id;
  Future person() async {
    http.Response data = await http.get(Uri.encodeFull(
        'https://api.themoviedb.org/3/person/$id?api_key=2931998c3a80d7806199320f76d65298'));
    this.setState(() {
      actor = json.decode(data.body);
      // print(actor);
    });
  }

  Future movies() async {
    http.Response details = await http.get(Uri.encodeFull(
        "https://api.themoviedb.org/3/person/$id/movie_credits?api_key=2931998c3a80d7806199320f76d65298"));
    this.setState(() {
      mov = json.decode(details.body);
      print(mov["cast"][0]["title"]);
    });
  }

  @override
  void initState() {
    id = "${widget.idea}";
    this.person();
    this.movies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(actor["name"]),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              // color: Colors.pinkAccent,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                          "https://image.tmdb.org/t/p/w500/" +
                              actor['profile_path']),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      height: 200.0,
                        child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Dob",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(actor["birthday"]),
                          Text(
                            "BirthPLace",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                         
                          Flexible(
                                child: Text( actor["place_of_birth"],
                                    overflow: TextOverflow.clip)),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: Text(
                  "About " + actor["name"],
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(child: Text(actor["biography"])),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: Text(
                  "Movies",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              height: 250.0,
              child: ListView.builder(
                itemCount:
                    mov == 0 ? mov['cast'].length == null : mov['cast'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  data: mov["cast"][index]["id"],
                                ))),
                    child: new Card(
                      semanticContainer: true,
                      //  margin: EdgeInsets.only(right: 10),
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        width: 130,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 190,
                              width: 120,
                              child: Builder(builder: (BuildContext context) {
                                try {
                                  return Image.network(
                                    'https://image.tmdb.org/t/p/w500/' +
                                        mov["cast"][index]["poster_path"],
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
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(mov["cast"][index]["title"],
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// https://api.themoviedb.org/3/person/86302/movie_credits?api_key=2931998c3a80d7806199320f76d65298
// https://api.themoviedb.org/3/person/86302?api_key=2931998c3a80d7806199320f76d65298
