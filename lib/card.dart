import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:last_app/detail.dart';
import 'grid.dart';
import 'package:http/http.dart' as http;

class Hview extends StatefulWidget {
  @override
  _HviewState createState() => _HviewState();
}

class _HviewState extends State<Hview> {
  bool sbar = false;
  var popmov, thisyr;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _search = new TextEditingController();
  String name;
  void cha() {
    setState(() {
      _search.clear();
      sbar = sbar ? false : true;
    });
  }

  Future popular() async {
    http.Response result = await http.get(Uri.encodeFull(
        'https://api.themoviedb.org/3/discover/movie?api_key=2931998c3a80d7806199320f76d65298&region=IN&language=hi-IN&with_original_language=hi&page=1'));
    //  https://api.themoviedb.org/3/discover/movie?api_key=2931998c3a80d7806199320f76d65298&region=IN&language=hi-IN&with_original_language=hi&page=1
    this.setState(() {
      popmov = json.decode(result.body);
    });
  }

  Future thisyear() async {
    http.Response result = await http.get(Uri.encodeFull(
        'https://api.themoviedb.org/3/discover/movie?api_key=2931998c3a80d7806199320f76d65298&language=hi&region=in&sort_by=popularity.desc&page=1&primary_release_year=2019'));
    //  https://api.themoviedb.org/3/discover/movie?api_key=2931998c3a80d7806199320f76d65298&region=IN&language=hi-IN&with_original_language=hi&page=1
    this.setState(() {
      thisyr = json.decode(result.body);
      print(thisyr[0]["id"]);
    });

  }

  @override
  void initState() {
    this.popular();
    this.thisyear();
  }

// https://api.themoviedb.org/3/discover/movie?api_key=2931998c3a80d7806199320f76d65298&language=hi&region=in&sort_by=popularity.desc&page=1&primary_release_year=2019
  void _searchmovies(String text) {
    name = text;
    if (name.length > 1) {
      print(name.length);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieGrid(
                    data: name,
                  )));
    } else {
      print("Weeoe");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://placeimg.com/640/480/any/78"),
                  ),
                  accountName: new Text("Ankit Jain"),
                  accountEmail: null),
              new ListTile(
                leading: new Icon(Icons.movie_creation),
                title: Text("Watch List"),
                onTap: () => Navigator.pushNamed(context, '/grid'),
              ),
              new ListTile(
                leading: new Icon(Icons.favorite),
                title: Text("Favorite Movies"),
                onTap: () => Navigator.pushNamed(context, '/grid'),
              ),
              new ListTile(
                leading: new Icon(Icons.playlist_play),
                title: Text("TV sHOWS"),
                onTap: () => Navigator.pushNamed(context, '/grid'),
              ),
              Divider(),
              new ListTile(
                leading: new Icon(Icons.supervised_user_circle),
                title: Text("About us"),
              ),
              new ListTile(
                leading: new Icon(Icons.live_help),
                title: Text("Support"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: sbar
              ? TextField(
                  key: _formkey,
                  controller: _search,
                  onSubmitted: _searchmovies,
                  decoration: InputDecoration(
                      hintText: "Search Movies..",
                      hintStyle: TextStyle(color: Colors.white)),
                )
              : Text("BoxOffice"),
          actions: <Widget>[
            sbar
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: cha,
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: cha,
                  ),
          ],
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 12),
                new Text('Popular',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
                Spacer(),
                GestureDetector(
                  child: Text('View all  '),
                  onTap: () => Navigator.pushNamed(context, '/grid'),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 250,
              child: new ListView.builder(
                // itemCount: 0:popmov==null?20;
                itemCount: popmov == 0
                    ? popmov["results"].length == null
                    : popmov["results"].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  data: popmov["results"][index + 1]["id"],
                                ))),
                    child: new Card(
                      semanticContainer: true,
                      //  margin: EdgeInsets.only(right: 10),
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        width: 320,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 194,
                              width: 3100,
                              // size: Size(2000, 1500),
                              child: Builder(builder: (BuildContext context) {
                                try {
                                  return Image.network(
                                    'https://image.tmdb.org/t/p/w500/' +
                                        popmov["results"][index + 1]
                                            ["backdrop_path"],
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
                                Text(
                                  popmov["results"][index + 1]["title"],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {},
                                )
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
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 12),
                new Text('Upcoming..',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
                Spacer(),
                GestureDetector(
                  child: Text('View all    '),
                  onTap: () => Navigator.pushNamed(context, '/grid'),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              // width:100,
              height: 250,
              child: new ListView.builder(
                itemCount: thisyr == 0
                    ? thisyr['results'].length == null
                    : thisyr['results'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  data: thisyr["results"][index]["id"],
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
                                        thisyr["results"][index]["poster_path"],
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
                                  child: Text(thisyr["results"][index]["title"],
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
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 12),
                new Text('Now Playing',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
                Spacer(),
                GestureDetector(
                  child: Text('View all    '),
                  onTap: () => Navigator.pushNamed(context, '/grid'),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 250,
              child: new ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return new Card(
                    semanticContainer: true,
                    //  margin: EdgeInsets.only(right: 10),
                    elevation: 2,
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      width: 250,
                      child: Column(
                        children: <Widget>[
                          Image.network('https://placeimg.com/640/480/any/3',
                              fit: BoxFit.contain),
                          Row(
                            children: <Widget>[
                              Text('Avengers: End Game'),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        )));
  }
}
